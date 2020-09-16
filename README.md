> 提醒： 免费空间请不要滥用！！！

本项目支持部署kintohub和heroku两个空间，下面是部署到kintohub方法，部署到heroku方法请见：[Deploy to Heroku
](https://github.com/yeahwu/kinto/blob/master/v2-heroku.md)

利用kintohub免费空间部署v2ray和tor，部署成功后，可用v2ray客户端直接访问tor网络，比如暗网.onion，v2ray.json文件中设置了路由分流了tor网络，非tor流量不受影响。

### 部署服务端
1. 点开 https://app.kintohub.com/ 新建一个APP，点击 Create Service ,然后创建 Web App 如图：

![创建 web app](/img/ktv1)

2. Repository 填上git链接和默认分支master

![repository](/img/ktv2)

3. Build Settings 文件名填写Dockerfile，端口填上8080，填写如下：

![build](/img/ktv3)

最后点击右上角 Deploy，部署完成，会生成一个链接，点击链接，如果显示Bad Request，即为成功。

### 客户端配置

客户端配置如图，加速可使用Cloudflare CDN workes缓存，使用cloudflare.com或优选IP接入：

![v2ray](/img/kinto3.jpg)
![v2ray](/img/ktv4)

默认UUID：ad806487-2d26-4636-98b6-ab85cc8521f7

### 修改UUID

方法一：

v2ray的配置文件config.json，可以改为自己的私密链接，比如 https://gist.github.com/ 里自定义v2ray配置，当然你也可参考本项目的config.json配置，然后生成链接。最后部署的时候写入到Environment variables里，如图：

![gist](/img/kinto4.jpg)

方法二：

Fork本项目，到config.json里面修改uuid或其它，然后到Dockerfile里面修改ENV CONFIG= 指向链接，例如：`ENV CONFIG=https://raw.githubusercontent.com/wellshe/ktv/master/config.json`指向你自己项目的config.json文件。

支持本博：https://starts.sh/donation.html

测试暗网地址：http://vq7kihyfoqcoluju.onion/donation.html
