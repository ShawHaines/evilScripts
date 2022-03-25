# evilScripts

Some evil script collection useful in Zhejiang University.

* `ZJU-Sign-in-ClassRoom-Alert.js`(浙江大学智云课堂签到提示) An assistant that watches the subtitles on ZJU classroom (浙江大学智云课堂) and sends you alert when the teacher asks to sign in.
* `NexusHD_sign_in/` A shell script based on curl that automatically signs in for you on [NexusHD](http://www.nexushd.org) (a private torrent website exclusive to ZJU members). 
* `CC98_sigin_in/` A shell script based on curl that automatically signs in for you on [CC98](https://www.cc98.org) (an internal forum also exclusive to ZJU members). 

## ZJU-Sign-in-ClassRoom-Alert

~~Available on [Greasy Fork](https://greasyfork.org/en/)~~

Copy & paste the content into a [Tampermonkey](https://www.tampermonkey.net) script.


## NexusHD_sign_in

It's a minimalist script inspired by [XinArkh/NexusHD_AutoCheck](https://github.com/XinArkh/NexusHD_AutoCheck). Unlike its predecessor, it is based on `curl` that does not depend on any additional libraries, or python.

Prerequsite: accessible to ZJU internal network.

### Single user, temporary run

Navigate to the folder containing the scripts, simply type

```bash
./nhd_curl.sh <username> <password>
```

### Multiple users

Fill in your list of username and password in the **local** copy of [nhd_password.txt](./NexusHD_sign_in/nhd_password.txt)

Format specification: In each line, `username:password` (separated by half-width colon and nothing else)

example:

```
ZhaohuiWu:123456
PeppaPig:123456
```

Run

```
./nhd_autosign.sh
```

### Scheduled task

On Linux or OpenWRT server, use `crontab` command to setup scheduled task.

```bash
# edit scheduled task
crontab -e
```

In the editor that follows, type

```bash
# automatically sign in for NHD at 08:00 am everyday.
00 08 * * * cd /path/to/script; ./nhd_autosign.sh
```

### CC98_sign_in

An expansion to `NexusHD_sign_in`. Its usage is similar to [NexusHD_sign_in](#nexushd_sign_in)