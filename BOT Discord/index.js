const Discord = require('discord.js');
const Enmap = require("enmap");
const fs = require("fs");

const bot = new Discord.Client({ partials: ['MESSAGE', 'CHANNEL', 'REACTION'] });
const config = require("./config/config.json");

var functionUtils = require("./utils/functions/functions.js")
bot.config = config;

fs.readdir("./events/", (err, files) => {
    if (err) return console.error(err);
    files.forEach(file => {
        const event = require(`./events/${file}`);
        let eventName = file.split(".")[0];
        bot.on(eventName, event.bind(null, bot));
    });
});
  
bot.commands = new Enmap();
  
fs.readdir("./commands/", (err, files) => {
    if (err) return console.error(err);
        files.forEach(file => {
        if (!file.endsWith(".js")) return;
        let props = require(`./commands/${file}`);
        let commandName = file.split(".")[0];
        console.log(`[+] Commande : ${commandName}`);
        bot.commands.set(commandName, props);
    });
});

bot.login(config.TOKEN);
setInterval(functionUtils.data.setPlayerConnected, 300000, bot);
