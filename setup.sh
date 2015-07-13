#!/bin/bash
#自动安装amp环境

#定义常量
name=$(whoami)
path=/lamp

#同步时间
if [ "$(rpm -qa ntpdate | grep ntpdate-)" == 0 ];then
        yum -y install ntpdate
        echo "At $(date): rpm包ntpdate安装完成" >> $path/install.log
else
        echo "At $(date): rpm包ntpdate已经安装" >> $path/install.log
fi
ntpdate asia.pool.ntp.org &> /dev/null

#判断包目录是否存在,不存在就创建
if [ ! -d $path ];then
        mkdir $path
        echo "At $(date): 包目录$path 不存在,已创建" >> $path/install.log
else
        echo "At $(date): 包目录$path 已存在,无需创建" >> $path/install.log
fi

cd $path

#清空目录
#ls $path | grep -v *.xz > ~/ls.log
#rm -rf $path/$(cat ~/ls.log) /usr/lical/libxml2

rm -rf $path/*

echo "At $(date): 环境搭建开始" > $path/install.log
#检查并卸载
service httpd stop
/usr/local/apache2/bin/apachectl stop
service httpd mysql
/usr/local/mysql/bin/mysqladmin shutdown -u root -p
rpm -e httpd mysql php &> /dev/null
yum -y remove httpd mysql php &> /dev/null

echo "At $(date): httpd mysql php 卸载完成" >> $path/install.log

#判断是否已经设置行号显示,未设置便设置
if [ "$(grep nu ~/.vimrc)" == 0 ];then
        echo '"设置显示行号' >> ~/.vimrc
        echo 'set nu' >> ~/.vimrc
fi

#判断yum包安装与否
if [ "$(rpm -qa nmap | grep nmap-)" == 0 ];then
        yum -y install nmap
        echo "At $(date): rpm包nmap安装完成" >> $path/install.log
else
        echo "At $(date): rpm包nmap已经安装" >> $path/install.log
fi


if [ "$(rpm -qa dos2unix | grep dos2unix-)" == 0 ];then
        yum -y install dos2unix
	echo "At $(date): rpm包dos2unix安装完成" >> $path/install.log
else
        echo "At $(date): rpm包dos2unix已经安装" >> $path/install.log
fi


if [ "$(rpm -qa gcc | grep gcc-)" == 0 ];then
        yum -y install gcc 
        echo "At $(date): rpm包gcc安装完成" >> $path/install.log
else
        echo "At $(date): rpm包gcc已经安装" >> $path/install.log
fi


if [ "$(rpm -qa gcc-c++ | grep gcc-c++-)" == 0 ];then
        yum -y install gcc-c++ 
        echo "At $(date): rpm包gcc-c++安装完成" >> $path/install.log
else
        echo "At $(date): rpm包gcc-c++已经安装" >> $path/install.log
fi


if [ "$(rpm -qa make | grep make-)" == 0 ];then
        yum -y install make 
        echo "At $(date): rpm包make安装完成" >> $path/install.log
else
        echo "At $(date): rpm包make已经安装" >> $path/install.log
fi


if [ "$(rpm -qa python-devel | grep python-devel-)" == 0 ];then
        yum -y install python-devel 
        echo "At $(date): rpm包python-devel安装完成" >> $path/install.log
else
        echo "At $(date): rpm包python-devel已经安装" >> $path/install.log
fi


if [ "$(rpm -qa libtool* | grep libtool-)" == 0 ];then
        yum -y install libtool 
        echo "At $(date): rpm包libtool*安装完成" >> $path/install.log
else
        echo "At $(date): rpm包libtool*已经安装" >> $path/install.log
fi


if [ "$(rpm -qa cmake | grep cmake-)" == 0 ];then
        yum -y install cmake 
        echo "At $(date): rpm包cmake安装完成" >> $path/install.log
else
        echo "At $(date): rpm包cmake已经安装" >> $path/install.log
fi


if [ "$(rpm -qa bison | grep bison-)" == 0 ];then
        yum -y install bison 
        echo "At $(date): rpm包bison安装完成" >> $path/install.log
else
        echo "At $(date): rpm包bison已经安装" >> $path/install.log
fi


if [ "$(rpm -qa zlib-devel | grep zlib-devel-)" == 0 ];then
        yum -y install zlib-devel 
        echo "At $(date): rpm包zlib-devel安装完成" >> $path/install.log
else
        echo "At $(date): rpm包zlib-devel已经安装" >> $path/install.log
fi


if [ "$(rpm -qa libevent* | grep libevent-)" == 0 ];then
        yum -y install libevent* 
        echo "At $(date): rpm包libevent*安装完成" >> $path/install.log
else
        echo "At $(date): rpm包libevent*已经安装" >> $path/install.log
fi

echo "At $(date): amp环境所需rpm包检测完成" >> $path/install.log

#判断日志文件目录是否存在,不存在就创建
if [ ! -d $path/logs ];then
        mkdir $path/logs
        echo "At $(date): 日志文件目录$path/logs 不存在,已创建" >> $path/install.log
else
        echo "At $(date): 日志文件目录$path/logs 已存在,无需创建" >> $path/install.log
fi

#xxxxxxxxxxxxxxxxxx判断是否下载libxml2xxxxxxxxxxxxxxxxxx
#if [ ! -f $path/alibxml2-2.9.1.tar.xz ];then
        wget -o $path/logs/1.libxml2.log -O $path/alibxml2-2.9.1.tar.xz -c https://github.com/mouyong/lamp/blob/master/libxml2-2.9.1.tar.xz?raw=true
        echo "1. At $(date): libxml2-2.9.1.tar.xz 下载完成" >> $path/install.log
#fi
#echo "1. At $(date): libxml2-2.9.1.tar.xz 无需下载" >> $path/install.log
echo "1. At $(date): libxml2-2.9.1.tar.xz 开始安装" >> $path/install.log
tar -Jxf alibxml2-2.9.1.tar.xz
cd $path/libxml2-2.9.1

echo '--------------------万恶的configure分割线--------------------' > $path/logs/1.libxml2.log
./configure --prefix=/usr/local/libxml2 >> $path/logs/1.libxml2.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/1.libxml2.log
        make >> $path/logs/1.libxml2.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                rm -rf /usr/local/libxml2
                echo "1. At $(date): libxml2-2.9.1.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 101" >> $path/install.log
                echo 101
                exit 101

        else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/1.libxml2.log
                make install >> $path/logs/1.libxml2.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        rm -rf /usr/local/libxml2
                        echo "1. At $(date): libxml2-2.9.1.tar.xz 安装失败.配置已清除,文件已删除-------------------exit 102." >> $path/install.log
                        echo 102
                        exit 102
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/1.libxml2.log
        fi

        echo "1. At $(date): libxml2-2.9.1.tar.xz 安装完成" >> $path/install.log
        echo '1. libxml2 安装路径为 /usr/local/libxml2' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        rm -rf /usr/local/libxml2
        echo "1. At $(date): libxml2-2.9.1.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 103" >> $path/install.log
        echo 103
        exit 103
fi


#xxxxxxxxxxxxxxxxx判断是否下载libmcryptxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/blibmcrypt-2.5.8.tar.xz ];then
        wget -o $path/logs/2.libmcrypt.log -O $path/blibmcrypt-2.5.8.tar.xz -c https://github.com/mouyong/lamp/blob/master/libmcrypt-2.5.8.tar.xz?raw=true
        echo "2. At $(date): libmcrypt-2.5.8.tar.xz 下载完成" >> $path/install.log
#fi
#echo "2. At $(date): libmcrypt-2.5.8.tar.xz 无需下载" >> $path/install.log
echo "2. At $(date): libmcrypt-2.5.8.tar.xz 开始安装" >> $path/install.log
cd $path
tar -Jxf blibmcrypt-2.5.8.tar.xz
cd $path/libmcrypt-2.5.8

echo '--------------------万恶的configure分割线--------------------' > $path/logs/2.libmcrypt.log
./configure --prefix=/usr/local/libmcrypt >> $path/logs/2.libmcrypt.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/2.libmcrypt.log
        make >>  $path/logs/2.libmcrypt.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                rm -rf /usr/local/libmcrypt
                echo "2. At $(date): libmcrypt-2.5.8.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 201" >> $path/install.log
                echo 201
                exit 201

        else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/2.libmcrypt.log
                make install >> $path/logs/2.libmcrypt.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        rm -rf /usr/local/libmcrypt
                        echo "2. At $(date): libmcrypt-2.5.8.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 202" >> $path/install.log
                        echo 202
                        exit 202
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/2.libmcrypt.log
                cd $path/libmcrypt-2.5.8/libltdl
                ./configure --enable-ltdl-install
                make && make install
                if [ "$?" == 0 ];then
                        echo "2. At $(date): libmcrypt/libltdl 安装成功 !!!" >> $path/install.log
                else
                        make clean
                        make uninstall  
                        echo "2. At $(date): libmcrypt/libltdl 安装失败 !!!" >> $path/install.log
                fi
        fi

        echo "2. At $(date): libmcrypt-2.5.8.tar.xz 安装完成" >> $path/install.log
        echo '2. libmcrypt 安装路径为 /usr/local/libmcrypt' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        rm -rf /usr/local/libmcrypt
        echo "2. At $(date): libmcrypt-2.5.8.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 203" >> $path/install.log
        echo 203
        exit 203
fi


#xxxxxxxxxxxxxxxxx判断是否下载mhashxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/cmhash-0.9.9.9.tar.xz ];then
        wget -o $path/logs/3.mhash.log -O $path/cmhash-0.9.9.9.tar.xz -c https://github.com/mouyong/lamp/blob/master/mhash-0.9.9.9.tar.xz?raw=true
        echo "3. At $(date): mcrypt-2.6.8.tar.xz 下载完成" >> $path/install.log
#fi
#echo "3. At $(date): mhash-0.9.9.9.tar.xz 无需下载" >> $path/install.log
echo "3. At $(date): mhash-0.9.9.9.tar.xz 开始安装" >> $path/install.log
cd $path
tar -Jxf cmhash-0.9.9.9.tar.xz
cd $path/mhash-0.9.9.9

echo '--------------------万恶的configure分割线--------------------' > $path/logs/3.mhash.log
./configure

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/3.mhash.log
        make >>  $path/logs/3.mhash.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                make uninstall
                echo "3. At $(date): mhash-0.9.9.9.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 301" >> $path/install.log
                echo 301
                exit 301

        else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/3.mhash.log
                make install >> $path/logs/3.mhash.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        make uninstall
                        echo "3. At $(date): mhash-0.9.9.9.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 302" >> $path/install.log
                        echo 302
                        exit 302
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/3.mhash.log
        fi
 
        echo "3. At $(date): mhash-0.9.9.9.tar.xz 安装完成" >> $path/install.log
        echo '3. mhash 安装路径为 默认' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        make uninstall
        echo "3. At $(date): mhash-0.9.9.9.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 303" >> $path/install.log
        echo 303
        exit 303
fi


#xxxxxxxxxxxxxxxxx判断是否下载mcryptxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/dmcrypt-2.6.8.tar.xz ];then
        wget -o $path/logs/4.mcrypt.log -O $path/dmcrypt-2.6.8.tar.xz -c https://github.com/mouyong/lamp/blob/master/mcrypt-2.6.8.tar.xz?raw=true
        echo "4. At $(date): mcrypt-2.6.8.tar.xz 下载完成" >> $path/install.log
#fi
#echo "4. At $(date): mcrypt-2.6.8.tar.xz 无需下载" >> $path/install.log
echo "4. At $(date): 1. mcrypt-2.6.8.tar.xz 开始安装" >> $path/install.log
cd $path
tar -Jxf dmcrypt-2.6.8.tar.xz
cd $path/mcrypt-2.6.8

echo '--------------------万恶的configure分割线--------------------' > $path/logs/4.mcrypt.log
LD_LIBRARY_PATH=/usr/local/libmcrypt/lib:/usr/local/lib \
./configure \
--with-libmcrypt-prefix=/usr/local/libmcrypt >> $path/logs/4.mcrypt.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/4.mcrypt.log
        make >>  $path/logs/4.mcrypt.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                make uninstall
                echo "4. At $(date): 1. mcrypt-2.6.8.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 401" >> $path/install.log
                echo 401
                exit 401

        else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/4.mcrypt.log
                make install >> $path/logs/4.mcrypt.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        make uninstall
                        echo "4. At $(date): 1. mcrypt-2.6.8.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 402" >> $path/install.log
                        echo 402
                        exit 402
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/4.mcrypt.log
        fi

        echo "4. At $(date): 1. mcrypt-2.6.8.tar.xz 安装完成" >> $path/install.log
        echo '4. 1. mcrypt 安装路径为 默认' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        make uninstall
        echo "4. At $(date): 1. mcrypt-2.6.8.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 403" >> $path/install.log
        exit 403
fi


#xxxxxxxxxxxxxxxxx判断是否下载zlibxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/ezlib-1.2.3.tar.xz ];then
        wget -o $path/logs/5.zlib.log -O $path/ezlib-1.2.3.tar.xz -c https://github.com/mouyong/lamp/blob/master/zlib-1.2.3.tar.xz?raw=true
        echo "5. At $(date): zlib-1.2.3.tar.xz 下载完成" >> $path/install.log
#fi
#echo "5. At $(date): zlib-1.2.3.tar.xz 无需下载" >> $path/install.log
echo "5. At $(date): zlib-1.2.3.tar.xz 开始安装" >> $path/install.log
cd $path
tar -Jxf ezlib-1.2.3.tar.xz
cd $path/zlib-1.2.3

echo '--------------------万恶的configure分割线--------------------' > $path/logs/5.zlib.log
./configure --shared >> $path/logs/5.zlib.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/5.zlib.log
        make >>  $path/logs/5.zlib.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                make uninstall
                echo "5. At $(date): zlib-1.2.3.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 501" >> $path/install.log
                echo 501
                exit 501

        else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/5.zlib.log
                make install >> $path/logs/5.zlib.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        make uninstall
                        echo "5. At $(date): zlib-1.2.3.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 502" >> $path/install.log
                        echo 502
                        exit 502
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/5.zlib.log
        fi
 
        echo "5. At $(date): zlib-1.2.3.tar.xz 安装完成" >> $path/install.log
        echo '5. zlib 安装路径为 默认' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        make uninstall
        echo "5. At $(date): zlib-1.2.3.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 503" >> $path/install.log
        echo 503
        exit 503
fi


#xxxxxxxxxxxxxxxxx判断是否下载libpngxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/flibpng-1.2.31.tar.xz.tar.xz ];then
        wget -o $path/logs/6.libpng.log -O $path/flibpng-1.2.31.tar.xz -c https://github.com/mouyong/lamp/blob/master/libpng-1.2.31.tar.xz?raw=true
        echo "6. At $(date): libpng-1.2.31.tar.xz.tar.xz 下载完成" >> $path/install.log
#fi
#echo "6. At $(date): libpng-1.2.31.tar.xz 无需下载" >> $path/install.log
echo "6. At $(date): libpng-1.2.31.tar.xz 开始安装" >> $path/install.log
cd $path
tar -Jxf flibpng-1.2.31.tar.xz
cd $path/libpng-1.2.31

echo '--------------------万恶的configure分割线--------------------' > $path/logs/6.libpng.log
./configure --prefix=/usr/local/libpng >> $path/logs/6.libpng.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/6.libpng.log
        make >>  $path/logs/6.libpng.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                rm -rf /usr/local/libpng
                echo "6. At $(date): libpng-1.2.31.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 601" >> $path/install.log
                echo 601
                exit 601

         else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/6.libpng.log
                make install >> $path/logs/6.libpng.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        rm -rf /usr/local/libpng
                        echo "6. At $(date): libpng-1.2.31.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 602" >> $path/install.log
                        echo 602
                        exit 602
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/6.libpng.log
        fi
 
        echo "6. At $(date): libpng-1.2.31.tar.xz 安装完成" >> $path/install.log
        echo '6. libpng 安装路径为 /usr/local/libpng' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        rm -rf /usr/local/libpng
        echo "6. At $(date): libpng-1.2.31.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 603" >> $path/install.log
        echo 603
        exit 603
fi


#xxxxxxxxxxxxxxxxx判断是否下载jpegxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/gjpegsrc.v6b.tar.xz ];then
        wget -o $path/logs/7.jpeg.log -O $path/gjpegsrc.v6b.tar.xz -c https://github.com/mouyong/lamp/blob/master/jpegsrc.v6b.tar.xz?raw=true
        echo "7. At $(date): jpegsrc.v6b.tar.xz 下载完成" >> $path/install.log
#fi
#echo "7. At $(date): jpegsrc.v6b.tar.xz 无需下载" >> $path/install.log
echo "7. At $(date): jpegsrc.v6b.tar.xz 开始安装" >> $path/install.log
mkdir -p /usr/local/jpeg6/{bin,lib,include,man/man1}
cd $path
tar -Jxf gjpegsrc.v6b.tar.xz
cd $path/jpeg-6b

/bin/cp /usr/share/libtool/config/config.* .
echo '--------------------万恶的configure分割线--------------------' > $path/logs/7.jpeg.log
./configure --prefix=/usr/local/jpeg6 \
--enable-shared \
--enable-static >> $path/logs/7.jpeg.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/7.jpeg.log
        make >>  $path/logs/7.jpeg.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                rm -rf /usr/local/jpeg6
                echo "7. At $(date): jpegsrc.v6b.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 701" >> $path/install.log
                echo 701
                exit 701

         else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/7.jpeg.log
                make install >> $path/logs/7.jpeg.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        rm -rf /usr/local/jpeg6
                        echo "7. At $(date): jpegsrc.v6b.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 702" >> $path/install.log
                        echo 702
                        exit 702
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/7.jpeg.log
        fi
 
        echo "7. At $(date): jpegsrc.v6b.tar.xz 安装完成" >> $path/install.log
        echo '7. jpeg6 安装路径为 /usr/local/jpeg6' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        rm -rf /usr/local/jpeg
        echo "7. At $(date): jpegsrc.v6b.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 703" >> $path/install.log
        echo 703
        exit 703
fi


#xxxxxxxxxxxxxxxxx判断是否下载freexxxxxxxxxxxxxxxxxx
#if [ ! -f $path/hfreetype-2.3.5.tar.xz ];then
        wget -o $path/logs/8.freetype.log -O $path/hfreetype-2.3.5.tar.xz -c https://github.com/mouyong/lamp/blob/master/freetype-2.3.5.tar.xz?raw=true
        echo "8. At $(date): freetype-2.3.5.tar.xz 下载完成" >> $path/install.log
#fi
cd $path
tar -Jxf hfreetype-2.3.5tar.xz
cd $path/freetype-2.3.5

echo '--------------------万恶的configure分割线--------------------' > $path/logs/8.freetype.log
./configure --prefix=/usr/local/freetype >> $path/logs/8.freetype.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/7.jpeg.log
        make >>  $path/logs/7.jpeg.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                rm -rf /usr/local/freetype
                echo "7. At $(date): freetype-2.3.5tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 801" >> $path/install.log
                echo 801
                exit 801

         else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/8.freetype.log
                make install >> $path/logs/8.freetype.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        rm -rf /usr/local/freetype
                        echo "8. At $(date): freetype-2.3.5tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 802" >> $path/install.log
                        echo 802
                        exit 802
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/8.freetype.log
        fi
 
        echo "8. At $(date): freetype-2.3.5tar.xz 安装完成" >> $path/install.log
        echo '8. freetype 安装路径为 /usr/local/freetype' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        rm -rf /usr/local/freetype
        echo "7. At $(date): freetype-2.3.5tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 803" >> $path/install.log
        echo 803
        exit 803
fi


#xxxxxxxxxxxxxxxxx判断是否下载gdxxxxxxxxxxxxxxxxxx
#if [ ! -f $path/igd-2.0.35.tar.xz ];then
        wget -o $path/logs/9.gd.log -O $path/igd-2.0.35.tar.xz -c https://github.com/mouyong/lamp/blob/master/gd-2.0.35.tar.xz?raw=true
        echo "9. At $(date): gd-2.0.35.tar.xz 下载完成" >> $path/install.log
#fi
cd $path
tar -Jxf igd-2.0.35.tar.xz
cd $path/gd-2.0.35
sed -i "s/png\.h/\/usr\/local\/libpng\/include\/png\.h/g" $path/gd-2.0.35/gd_png.c

echo '--------------------万恶的configure分割线--------------------' > $path/logs/9.gd.log
./configure --prefix=/usr/local/gd2 \
--with-jpeg=/usr/local/jpeg6 \
--with-freetype=/usr/local/freetype \
--with-png=/usr/local/libpng

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/9.gd.log
        make >>  $path/logs/9.gd.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                rm -rf /usr/local/gd2
                echo "9. At $(date): gd-2.0.35.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 601" >> $path/install.log
                echo 901
                exit 901

         else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/9.gd.log
                make install >> $path/logs/9.gd.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        rm -rf /usr/local/gd2
                        echo "9. At $(date): gd-2.0.35.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 602" >> $path/install.log
                        echo 902
                        exit 902
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/9.gd.log
        fi
 
        echo "9. At $(date): gd-2.0.35.tar.xz 安装完成" >> $path/install.log
        echo '9. gd 安装路径为 /usr/local/gd2' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        rm -rf /usr/local/gd2
        echo "9. At $(date): gd-2.0.35.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 603" >> $path/install.log
        echo 903
        exit 903
fi


#xxxxxxxxxxxxxxxxx判断是否下载pcrexxxxxxxxxxxxxxxxxx
#if [ ! -f $path/jpcre-8.34.tar.xz ];then
        wget -o $path/logs/10.pcre.log -O $path/jpcre-8.34.tar.xz -c https://github.com/mouyong/lamp/blob/master/pcre-8.34.tar.xz?raw=true
        echo "10. At $(date): pcre-8.34.tar.xz 下载完成" >> $path/install.log
#fi
cd $path
tar -Jxf jpcre-8.34.tar.xz
cd $path/pcre-8.34

echo '--------------------万恶的configure分割线--------------------' > $path/logs/10.pcre.log
./configure >> $path/logs/10.pcre.log

if [ "$?" == 0 ];then
        echo '--------------------万恶的make分割线--------------------' >> $path/logs/10.pcre.log
        make >>  $path/logs/10.pcre.log
        if [ ! "$?" == 0 ];then
                #清除配置,删除文件
                make clean
                make uninstall
                echo "10. At $(date): pcre-8.34.tar.xz 安装失败.配置已清除,文件已删除.----------------------------exit 1001" >> $path/install.log
                echo 1001
                exit 1001

         else
                echo '--------------------万恶的make install分割线--------------------' >> $path/logs/10.pcre.log
                make install >> $path/logs/10.pcre.log
                if [ ! "$?" == 0 ];then
                        #清除配置,删除文件
                        make clean
                        make uninstall
                        echo "10. At $(date): pcre-8.34.tar.xz 安装失败.配置已清除,文件已删除.---------------------------------exit 1002" >> $path/install.log
                        echo 1002
                        exit 1002
                fi
                echo '=======================万恶的make install完成分割线=========================' >> $path/logs/10.pcre.log
        fi
 
        echo "10. At $(date): pcre-8.34.tar.xz 安装完成" >> $path/install.log
        echo '10. pcre 安装路径为 默认' >>  $path/install.log

else
        #清除配置,删除文件
        make clean
        make uninstall
        echo "10. At $(date): pcre-8.34.tar.xz 安装失败.配置已清除,文件已删除.-------------------------exit 603" >> $path/install.log
        echo 1003
        exit 1003
fi


