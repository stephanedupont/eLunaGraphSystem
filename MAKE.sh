#!/bin/bash

echo 
echo "!!!!!!!!!!!!!!!!!!!!"
echo "First, you need to remove the google analytics script frome template/index.html !!!";
echo "If it's not the case, CTRL+C !"
echo "!!!!!!!!!!!!!!!!!!!!"
echo 

echo -n "Version (exemple: 1.00) : "; \
read version; \

echo -n "Date (exemple: 2006-01-24) : "; \
read date; \

sed "s/^ # Version : ..../ # Version : $version/" index.pl > TEMP
mv -f TEMP index.pl

sed "s/^ # Version : ..../ # Version : $version/" update.pl > TEMP
mv -f TEMP update.pl

sed "s/^Version : ..../Version : $version/" README.french > TEMP
mv -f TEMP README.french

sed "s/^Version : ..../Version : $version/" README.english > TEMP
mv -f TEMP README.english

sed "s/^ # Date    : ........../ # Date    : $date/" index.pl > TEMP
mv -f TEMP index.pl

sed "s/^ # Date    : ........../ # Date    : $date/" update.pl > TEMP
mv -f TEMP update.pl

sed "s/^Date    : ........../Date    : $date/" README.french > TEMP
mv -f TEMP README.french

sed "s/^Date    : ........../Date    : $date/" README.english > TEMP
mv -f TEMP README.english

mkdir temp

cp index.pl temp
cp update.pl temp
cp LICENSE temp
cp README.* temp
cp CHANGELOG temp
cp -R template temp
cp -R rrd temp
cp -R graphs temp

sed "s/eLuna Web Server/Localhost/g" temp/index.pl > TEMP
mv -f TEMP temp/index.pl

chown -Rf root:root *
chmod -Rf 755 *
chmod -Rf 777 graphs
chmod -Rf 777 temp/graphs

cd temp

rm -Rf graphs/*
rm -Rf template/src
rm -Rf rrd/08_*
rm -Rf rrd/09_*

for i in rrd/* ; do rm $i/*.rrd ; done ;

tar -czf ../eluna_graph_system.tar.gz ./
rm -Rf ../out/$version
mkdir ../out/$version
mv ../eluna_graph_system.tar.gz ../out/$version
mv README.* ../out/$version
mv LICENSE ../out/$version
mv CHANGELOG ../out/$version
cd ..
rm -R temp
cd out
rm latest
ln -s $version latest
cd ..