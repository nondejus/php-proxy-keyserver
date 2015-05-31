#!/bin/bash

# http://devel-keyserver.mattrude.com/guides/dump-process/
# This script will stop the sks server, dump its contents to
# the $OUTDIR, then restart the sks server.

HOSTNAME='pgp.key-server.io'
CONTACT='carles.tubio@key-server.io'
BACKUPS=1
USER="debian-sks"
GROUP="pg1904948"
INDIR="/var/lib/sks"
PREDIR="dump"
SKSDATE=`date +%Y-%m-%d`
OUTDIR="$INDIR/$PREDIR/$SKSDATE"
COUNT="10000"
TZ='UTC'

cd $INDIR;
for DEL in `ls -1t dump | grep -v current | tail -n +$((BACKUPS+1))`; do
  echo "Deleting old directory $PREDIR/$DEL";
  rm -rf $PREDIR/$DEL;
done;

/usr/sbin/service sks stop;
sleep 2
if [ `ps -eaf | grep "sks " | grep -v 'grep sks' | wc -l` == "0" ]; then
  rm -rf $OUTDIR && mkdir -p $OUTDIR && \
  chown -R $USER:$GROUP $PREDIR && \
  /usr/local/bin/sks dump $COUNT $OUTDIR/ sks-dump;

  if [ `ps -eaf | grep "sks " | grep -v 'grep sks' | wc -l` == "0" ]; then
    /usr/sbin/service sks start;
  else
    echo "Unable to start SKS since it was already running.";
    exit 1;
  fi;

  cd $PREDIR/;
  rm -f current;
  ln -s $OUTDIR current;
else
  echo "Unable run backup, SKS is still running.";
  exit 1;
fi;

SIZE=`du -shc $OUTDIR |grep 'total' |awk '{ print $1 }'`;
DCOUNT=`grep "#Key-Count" $OUTDIR/metadata-sks-dump.txt |awk '{ print $2 }'`;
FILES=`grep "#Files-Count" $OUTDIR/metadata-sks-dump.txt |awk '{ print $2 }'`;
echo "This is the PGP key server dump from ${HOSTNAME} created at: `date -u`

These files were created basically with the following command: $ sks dump $COUNT $SKSDATE/ sks-dump

The current archive size is approximately $SIZE, holding $DCOUNT keys in $FILES files.

On a linux/unix system, you may download this directory via the following command:

  $ cd /var/lib/sks/dump 
  $ wget -c -r -p -e robots=off --timestamping --level=1 --cut-dirs=3 --no-host-directories https://${HOSTNAME}/dump/current/

After downloading the dump files, you can import them into a new empty dabatase with the following command:

  $ cd /var/lib/sks
  $ /usr/local/bin/sks_build.sh
  
and choose the option 2.

If all goes smoothly you'll end up with KDB and PTree directories in /var/lib/sks, and you are ready to start the daemons.

Also, if you would like to peer with this server, please send an email to <${CONTACT}> with your membership line." > $OUTDIR/README.txt;

cd $INDIR;
chown -R $USER:$GROUP $PREDIR;