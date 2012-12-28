#DPL 开发人员须知

##开发环境配置

###安装NodeJS

到nodejs[官方网站](http://nodejs.org/#download)，下载对应的安装包(mac:pkg|win:exe)，然后，你懂的。

目前nodejs的安装包都已经自带`npm`（nodejs的包管理器），所以npm就不需要额外独立安装了。

安装完成后，就可以在终端/CMD中直接使用node命令了

###安装依赖的node模块

在项目根目录，执行`npm update`，就会自动安装好所有的以来的包了，所有的以来定义在`package.json`文件中

###安装PhantomJS

PhantomJS用于单元测试，您看条件吧... 装不起来也不勉强

* Mac下面可以到官网下载可执行文件，加入到环境变量

mac用户还可以使用`brew`或者`port`这两种包管理器来安装，这样就省了添加环境变量的过程，当然前提是你装了这两个包管理器

* win下面同样是下载可执行文件，然后添加到环境变量中

###Windows下面使用Make命令

这个比较蛋疼，交给释然吧!坐等释然出教程

###Windows用户使用git自带的bash控制台

以为装好make就能用了么，想多了... 

直接在cmd中利用make命令执行makefile会有各种路径的问题，同时makefile里面定义的各种常用命令也都是linux下的，出错也难怪，使用git自带的那个bash可以解决这个问题。

###检查

如果你能跑通make build和make buildbs命令，基本上开发没问题了，最好make watch less也能跑起来，这样方便动态实时编译less源文件为css

##与开发相关的命令

* make buildbs

将less源文件编译为css，合并js脚本，并压缩优化什么的，最终会创建bootstrap目录，所有的结果都在里面。

* make build

这个命令主要是build文档，构造docs目录下的mustache模板为html文件，并将bootstrap文件夹下的js/css/img等赋值到docs目录下

* make test

使用PhantomJS和Quint进行单元测试

* make watchless

这个是通过调用**倪云建**童鞋的`DirWatcher`模块来监听less目录的变更，一旦就听到变更，就会执行`make buildbs`

该命令在windows下有问题，主要是nodeJS相关接口不兼容= =，有空看看能不能完善。

windows用户可以选用相关的`less`GUI工具来实现监听的目的，比如[winless](http://winless.org/)

* make watch

bootstrap自带的监听命令，但是发现无效果，大家自己看着办

##开发约定

所有的OCP的DPL相关less文件都存放在`less/ocp`目录下，不对bootstrap源文件进行更改，只进行样式的覆盖

另外我们在`less/ocp-test`目录下为每个模块添加测试页面，每个测试页面以模块的名称命名，比如`button`模块，则测试页面为`button.html`

###less/目录简单说明

less目录下原bootstrap源文件有多个，所有的文件都由`bootstrap.less`合并到一起（import）。为了达到覆盖的目的，我们在`less/ocp`目录下建立入口文件`ocp.less`，然后在`bootstrap.less`末尾import进来。

所有ocp中新增的模块都需要import进`ocp.less`文件

那么一个ocp模块的文件结构是：

	less
	----bootstrap.less
	----ocp
	--------ocp.less
	--------module.less
	----ocp-test
	--------mudule.html

###模块编写规范

* 尽量重用bootstrap中的`mixins`：具体可以参考`less/mixins.less`，或者参考同类模块
* 新增的ocp方法或者样式集合添加到`less/ocp/mixins.less`中，添加详细的注释划分好结构
* 每个模块一个less文件，每个模块开头添加详细说明
* 模块中只修改与模块本身有关的样式，不要污染其他样式。
* 所有的less变量都放在文件最上方，并为每个样式添加注释说明
* 所有的变量，使用驼峰命名法
* 所有的css选择器使用‘-’作为分隔符

###开发日志

有需要的话，可以在根据卢的devLog.md文件中添加内容，记录一些重要信息与变更，请注明时间

###代码提交

每一次代码提交之前，请至少执行过:

* make buildbs
* make build

都没问题后，在提交。请写清代码提交的commit 注释







