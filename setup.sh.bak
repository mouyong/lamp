#!/bin/bash
#一键install安装amp
#Author: Snail (E-mail: 1254075921@qq.com)

ntpdate asia.pool.ntp.org &> /dev/null

name=$(whoami | cat)
#read -t 60 -p 'Please enter lamp Installation package Path(输入所有amp环境相关文件所在的文件夹的绝对路径): ' path
path=/lamp
ls $path &> /dev/null
if [ -z "$path" -a "$?" == 1 ];then
	path=$(pwd)
	echo "At $(date): Error installing !!!   No enter Installation package Path" >> $path/install.log
	unset path
	exit 1
fi

echo "At $(date): Installation start ." > $path/install.log

echo "At $(date): Install Compiling package start !!!" >> $path/install.log
rpm -q nmap | grep -v nmap-
if [ $? == 0 ];then
	yum -y install nmap
fi
rpm -q gcc | grep -v gcc-
if [ $? == 0 ];then
	yum -y install gcc
fi
rpm -q gcc-c++ | grep -v gcc-c++-
if [ $? == 0  ];then
	yum -y install gcc-c++
fi
rpm -q python-devel | grep -v python-devel-
if [ $? == 0  ];then
	yum -y install python-devel
fi

echo "At $(date): Install Compiling package success !!!" >> $path/install.log

echo "At $(date): Install tar start !!!" >> $path/install.log
cd $path
ls *.tar.gz > ls.log
ls *.tgz >> ls.log
#exit 1: Error installing Compiling package
if [ "$?" == 0 ]
	then
		for i in $(cat ls.log)
        	do
            	tar -zxf $i
        	done
		rm -rf ls.log
		echo "At $(date): Install tar success !!!" >> $path/install.log
	else
		echo "At $(date): Error installing tar !!!   exit 1" >> $path/install.log
		exit 1
	fi

echo "At $(date): Install libxml2 start !!!" >> $path/install.log
cd $path/libxml2-2.9.1
./configure --prefix=/usr/local/libxml2
make && make install
#exit 2: Error installing libxml2
if [ "$?" == 0 ]
	then
		echo "At $(date): Install libxml2 success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing libxml2 !!!   exit 2" >> $path/install.log
		exit 2
	fi

echo "At $(date): Install libmcrypt start !!!" >> $path/install.log
cd $path/libmcrypt-2.5.8
./configure --prefix=/usr/local/libmcrypt
make && make install
#exit 3: Error installing libmcrypt
if [ "$?" == 0 ]
	then
		echo "At $(date): Install libmcrypt success !!!" >> $path/install.log


		echo "At $(date): Install libmcrypt/libltdl start !!!" >> $path/install.log
		cd $path/libmcrypt-2.5.8/libltdl
		./configure --enable-ltdl-install
		make && make install
		#exit 4: Error installing libltdl
		if [ "$?" == 0 ]
			then
				echo "At $(date): Install libmcrypt/libltdl success !!!" >> $path/install.log
			else
				make clean
				echo "At $(date): Error installing libmcrypt/libltdl !!!   exit 4" >> $path/install.log
				exit 4
			fi

	else
		make clean
		echo "At $(date): Error installing libmcrypt !!!   exit 3" >> $path/install.log
		exit 3
	fi

echo "At $(date): Install mhash start !!!" >> $path/install.log
cd $path/mhash-0.9.9.9
./configure
make && make install
#exit 5: Error installing mhash
if [ "$?" == 0 ]
	then
		echo "At $(date): Install mhash success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing mhash !!!   exit 5" >> $path/install.log
		exit 5
	fi

echo "At $(date): Install mcrypt start !!!" >> $path/install.log
cd $path/mcrypt-2.6.8
LD_LIBRARY_PATH=/usr/local/libmcrypt/lib:/usr/local/lib \
./configure \
--with-libmcrypt-prefix=/usr/local/libmcrypt
make && make install
#exit 6: Error installing mcrypt
if [ "$?" == 0 ]
	then
		echo "At $(date): Install mcrypt success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing mcrypt !!!   exit 6" >> $path/install.log
		exit 6
	fi

echo "At $(date): Install zlib start !!!" >> $path/install.log
cd $path/zlib-1.2.3
./configure --shared
make && make install
#exit 7: Error installing zlib
if [ "$?" == 0 ]
	then
		echo "At $(date): Install zlib success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing zlib !!!   exit 7" >> $path/install.log
		exit 7
	fi

echo "At $(date): Install libpng start !!!" >> $path/install.log
cd $path/libpng-1.2.31
./configure --prefix=/usr/local/libpng
make && make install
#exit 8: Error installing libpng
if [ "$?" == 0 ]
	then
		echo "At $(date): Install libpng success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing libpng !!!   exit 8" >> $path/install.log
		exit 8
	fi

echo "At $(date): Install jpeg start !!!" >> $path/install.log
yum -y install libtool
mkdir -p /usr/local/jpeg6/{bin,lib,include,man/man1}
cd $path/jpeg-6b
/bin/cp /usr/share/libtool/config/config.* .
./configure --prefix=/usr/local/jpeg6 \
--enable-shared \
--enable-static
make && make install
#exit 9: Error installing jpeg6
if [ "$?" == 0 ]
	then
		echo "At $(date): Install jpeg6 success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing jpeg6 !!!   exit 9" >> $path/install.log
		exit 9
	fi

echo "At $(date): Install freetype start !!!" >> $path/install.log
cd $path/freetype-2.3.5
./configure --prefix=/usr/local/freetype
make && make install
#exit 10: Error installing freetype
if [ "$?" == 0 ]
	then
		echo "At $(date): Install freetype success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing freetype !!!   exit 10" >> $path/install.log
		exit 10
	fi

echo "At $(date): Install gd start !!!" >> $path/install.log
cd $path/gd-2.0.35
sed -i "s/png\.h/\/usr\/local\/libpng\/include\/png\.h/g" gd_png.c
./configure --prefix=/usr/local/gd2 \
--with-jpeg=/usr/local/jpeg6 \
--with-freetype=/usr/local/freetype \
--with-png=/usr/local/libpng \
--enable-shared
make && make install
#exit 11: Error installing gd
if [ "$?" == 0 ]
	then
		echo "At $(date): Install gd success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing gd !!!   exit 11" >> $path/install.log
		exit 11
	fi

echo "At $(date): Install pcre start !!!" >> $path/install.log
cp -rf $path/apr-1.4.6 $path/httpd-2.4.7/srclib/apr
cp -rf $path/apr-util-1.4.1 $path/httpd-2.4.7/srclib/apr-util
cd $path/pcre-8.34
./configure
make && make install
#exit 12: Error installing pcre
if [ "$?" == 0 ]
	then
		echo "At $(date): Install pcre success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing pcre !!!   exit 12" >> $path/install.log
		exit 12
	fi

echo "At $(date): Install Apache start !!!" >> $path/install.log
cd $path/httpd-2.4.7
./configure --prefix=/usr/local/apache2 \
--with-included-apr \
--enable-so \
--enable-deflate=shared \
--enable-expires=shared \
--enable-rewrite=shared
make && make install
#exit 13: Error installing Apache
if [ "$?" == 0 ]
	then
		service iptables stop
		/usr/local/apache2/bin/apachectl start
		sed -i "s/^# system-specific logs may be also be configured here./\/usr\/local\/apache2\/logs\/access_log {\n    daily\n    create\n    rotate 30\n}\n\n# system-specific logs may be also be configured here./g" /etc/logrotate.conf
		sed -i "s/^# system-specific logs may be also be configured here./\/usr\/local\/apache2\/logs\/error_log {\n    daily\n    create\n    rotate 30\n}\n\n# system-specific logs may be also be configured here./g" /etc/logrotate.conf
		sed -i "s/^$/30 4 * * * logrotate \/usr\/local\/apache2\/logs\/access_log\n/g" /var/spool/cron/$name
		sed -i "s/^$/30 4 * * * logrotate \/usr\/local\/apache2\/logs\/error_log\n/g" /var/spool/cron/$name
		echo "/usr/local/apache2/bin/apachectl start" >> /etc/rc.d/rc.local
		ln -s /usr/local/apache2/htdocs ~/www
		echo "At $(date): Install Apache success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing Apache !!!   exit 13" >> $path/install.log
		exit 13
	fi

echo "At $(date): Install ncurses start !!!" >> $path/install.log
cd $path/ncurses-5.9
./configure \
--with-shared \
--without-debug \
--without-ada \
--enable-overwrite
make && make install
#exit 14: Error installing ncurses
if [ "$?" == 0 ]
	then
		echo "At $(date): Install ncurses success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing ncurses !!!   exit 14" >> $path/install.log
		exit 14
	fi

echo "At $(date): Install cmake & bison start !!!" >> $path/install.log
yum -y install cmake
yum -y install bison
#exit 15: Error installing cmake & bison
if [ "$?" == 0 ]
	then
		echo "At $(date): Install cmake & bison success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing cmake & bison !!!   exit 15" >> $path/install.log
		exit 15
	fi

echo "At $(date): Install MySQL start !!!" >> $path/install.log
groupadd mysql
useradd -g mysql mysql
cd $path/mysql-5.5.23
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_USER=mysql \
-DMYSQL_TCP_PORT=3306
make && make install
#exit 16: Error installing MySQL
if [ "$?" == 0 ]
	then
		cd /usr/local/mysql
		chown -R root .
		chgrp -R mysql .
		/usr/local/mysql/scripts/mysql_install_db --user=mysql
		chown -R root .
		chown -R mysql data
		\cp support-files/my-medium.cnf /etc/my.cnf
		/usr/local/mysql/scripts/mysql_install_db --user=mysql
		/usr/local/mysql/bin/mysqld_safe --user=mysql &
		echo "/usr/local/mysql/bin/mysqld_safe --user=mysql &" >> /etc/rc.d/rc.local
		/usr/local/mysql/bin/mysqladmin -u root password
		echo "At $(date): Install MySQL success !!!" >> $path/install.log
	else
		rm -rf CMakeCache.txt
		make clean
		echo "At $(date): Error installing MySQL !!!   exit 16" >> $path/install.log
		exit 16
	fi

echo "At $(date): Install PHP start !!!" >> $path/install.log
yum -y install "libtool*"
sed -i "s/}/  void (*data);\n\n}/g" /usr/local/gd2/include/gd_io.h
cd $path/php-5.4.25
./configure --prefix=/usr/local/php \
--with-apxs2=/usr/local/apache2/bin/apxs \
--with-mysql=/usr/local/mysql \
--with-libxml-dir=/usr/local/libxml2 \
--with-jpeg-dir=/usr/local/jpeg6 \
--with-png-dir=/usr/local/libpng \
--with-freetype-dir=/usr/local/freetype \
--with-gd=/usr/local/gd2 \
--with-mcrypt=/usr/local/libmcrypt \
--with-mysqli=/usr/local/mysql/bin/mysql_config \
--enable-soap \
--enable-mbstring=all \
--enable-sockets \
--with-pdo-mysql=/usr/local/mysql \
--with-zlib \
--enable-ftp \
--without-pear \
--enable-shared
make && make install
#exit 17: Error installing PHP
if [ "$?" == 0 ]
	then
		mkdir /usr/local/php/etc
		cp $path/php-5.4.25/php.ini-production /usr/local/php/etc/php.ini
		sed -i "s/index\.html/index\.html index\.php/g" /usr/local/apache2/conf/httpd.conf
		sed -i "s/    AddType application\/x-gzip \.gz \.tgz/    AddType application\/x-gzip \.gz \.tgz\n    AddType application\/x-httpd-php \.php/g" /usr/local/apache2/conf/httpd.conf
		/usr/local/apache2/bin/apachectl restart
		echo "At $(date): Install PHP success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing PHP !!!   exit 17" >> $path/install.log
		exit 17
	fi

echo "At $(date): Install memcache start !!!" >> $path/install.log
yum -y install zlib-devel
cd $path/memcache-3.0.8
/usr/local/php/bin/phpize
./configure \
--with-php-config=/usr/local/php/bin/php-config
make && make install
#exit 18: Error installing memcache
if [ "$?" == 0 ]
	then
		echo "At $(date): Install memcache success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing memcache !!!   exit 18" >> $path/install.log
		exit 18
	fi

echo "At $(date): Install mcrypt start !!!" >> $path/install.log
cd $path/php-5.4.25/ext/mcrypt
/usr/local/php/bin/phpize
./configure \
--with-php-config=/usr/local/php/bin/php-config \
--with-mcrypt=/usr/local/libmcrypt
make && make install
#exit 19: Error installing mcrypt
if [ "$?" == 0 ]
	then
		echo "At $(date): Install mcrypt success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing mcrypt !!!   exit 19" >> $path/install.log
		exit 19
	fi

echo "At $(date): Install Modified php.ini start !!!" >> $path/install.log
sed -i 's/\; extension_dir = ".\/"/extension_dir = "\/usr\/local\/php\/lib\/php\/extensions\/no-debug-zts-20100525\/"/g' /usr/local/php/etc/php.ini
echo 'extension="memcache.so";' >> /usr/local/php/etc/php.ini
echo 'extension="mcrypt.so";' >> /usr/local/php/etc/php.ini
#exit 20: Error modified php.ini
if [ "$?" == 0 ]
	then
		echo "At $(date): Modified php.ini success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error Modified php.ini !!!   exit 20" >> $path/install.log
		exit 20
	fi

echo "At $(date): Install memcached start !!!" >> $path/install.log
yum -y install "libevent*"
cd $path/memcached-1.4.17
./configure --prefix=/usr/local/memcache
make && make install
#exit 21: Error installing memcache
if [ "$?" == 0 ]
	then
		useradd memcache
		/usr/local/memcache/bin/memcached -umemcache &
		echo "/usr/local/memcache/bin/memcached -umemcache &" >> /etc/rc.d/rc.local
		echo "At $(date): Install memcache success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing memcache !!!   exit 21" >> $path/install.log
		exit 21
	fi

echo "At $(date): Install phpmyadmin start !!!" >> $path/install.log
cp -rf $path/phpMyAdmin-4.4.11-all-languages /usr/local/apache2/htdocs/phpmyadmin
cd /usr/local/apache2/htdocs/phpmyadmin
cp config.sample.inc.php config.inc.php
#exit 22: Error installing phpmyadmin
if [ "$?" == 0 ]
	then
		sed -i "s/\$cfg\['blowfish_secret'\] = '';/\$cfg\['blowfish_secret'\] = 'root';/g" /usr/local/apache2/htdocs/phpmyadmin/config.inc.php
		sed -i "s/\['AllowNoPassword'\] = false;/\['AllowNoPassword'\] = true;/g" /usr/local/apache2/htdocs/phpmyadmin/config.inc.php
		echo "At $(date): Install phpmyadmin success !!!" >> $path/install.log
	else
		make clean
		echo "At $(date): Error installing phpmyadmin !!!   exit 22" >> $path/install.log
		exit 22
	fi

unset path

echo "At $(date): 环境搭建完成 !!!" >> $path/install.log
echo "环境搭建完成"

