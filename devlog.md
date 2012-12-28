##开发日志

#### 2012-05-11

* 今天发现`make bootstrap` 一直提示错误：`make: `bootstrap' is up to date.`

原来是因为如果make发现目录下面有一个和命令一样名称的目录，就会报这个错误。

解决方法是将bootstrap命令修改为buildbs

* 发现`make watch`命令不起效，干脆使用我自己写的**DirWatcher**这个模块，已经在package.json中配置过，使用的时候`npm update`一下

现在要实时编译less，使用命令： `make watchless`


#### 2012-05-11

* fork Bootstrap
* 安装phantomjs
* 修改package.json里面的DevDependancies为dependancies，方便使用npm update
* **【注意】** `connect`版本使用指定的2.1.3版本，手动通过`npm install connect`安装的最新版，使用`make test`时`server.js`会出错
* 安装ruby的`watcher`模块，`make watch`命令需要用到

#### 2012-08-13

* less中不能写filter,如:filter: alpha(opacity = 15);
* 估计当成关键词应用了
