# How to set up a Minecraft server and connect with R

These instructions describe how to set up a Minecraft Server with the Raspberry Juice plugin. You can connect to this server using R and the `miner` package. In this setup, I am running Minecraft Server on Ubuntu in AWS and connecting from my workstation. My desktop has RStudio desktop and the Minecraft client installed. Note: If you are running Minecraft for the first time you will need to purchase a Minecraft account.

*These instructions borrow from [Fabrizzo Fazzino's Blog](http://simplyrisc.blogspot.com/2016/03/learn-to-program-with-minecraft-on.html) which also describes how to set up a Minecraft server with Raspberry Juice.*

## 1. Setup your server

Build a server. For these instructions I used a t2.medium instance on AWS running Ubuntu 16.04. Open these ports: 25565 (Minecraft) and 4711 (Raspberry Juice API). Install git and Java.

```
sudo apt-get install git
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```

## 2. Install Minecraft

Install Minecraft from [Spigot](https://www.spigotmc.org/wiki/spigot-installation/), a popular site for Minecraft server downloads. You will use the Buildtools program to complete the install. Run the `spigot-1.12.jar`. This step will fail to start the server but will successfully create the plugin directory and the EULA. 

```
sudo wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
sudo git config --global --unset core.autocrlf
sudo java -jar BuildTools.jar --rev 1.12
sudo java -Xms512M -Xmx1G -jar spigot-1.12.jar
```

Open the EULA with the command `vim eula.txt` and accept the terms 

```
eula=true
```

## 3. Install Raspberryjuice

Install the the [Raspberry Juice](https://dev.bukkit.org/projects/raspberryjuice) plugin so you can connect to Minecraft from R. Move Raspberry Juice into the plugins directory.

```
sudo wget https://github.com/zhuowei/RaspberryJuice/raw/master/jars/raspberryjuice-1.9.1.jar
mv raspberryjuice-1.9.1.jar plugins
```

## 4. Start your server

I recommend you turn on creative mode before starting your server. Modify the server properties by running `vim server.properties`. Set `gamemode=1` and `force-gamemode=true`. If you want to create a superflat world also set `level-type=FLAT`.

```
gamemode=1
force-gamemode=true
level-type=FLAT
```

Create a start script by running `vim start.sh` and entering the following lines. 

```
#!/bin/sh
java -Xms512M -Xmx1G -XX:+UseConcMarkSweepGC -jar spigot-1.12.jar
```

Start your Minecraft server. You should see a success message once the server is running (congratulations!). Next, try to login into your Minecraft server from your Minecraft desktop client.

```
chmod +x start.sh
./start.sh
```

[Optional] If you're having a hard time connecting, verify that your ports are open.

```
sudo apt-get install telnet
telnet <server-ip> 25565
telnet <server-ip> 4711
```

[Optional] Make your players operators. This will give them the ability to fly and access cheats.

```
/op <username>
```

## 5. Connect from R

Connect to your server from R using `mc_connect("<server-ip>")`. Test your connection by retrieving your player's location.

```
library(miner)
mc_connect("<server-ip>")
getPlayerIds()
```
