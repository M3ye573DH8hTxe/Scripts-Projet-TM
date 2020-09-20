var functionUtils = require("../utils/functions/functions.js")

exports.run = (bot, message, args) => {
    if(message.channel.id !== bot.config.CHANNEL_VERIFICATION) { 
        message.delete().then(msg => console.log(`Deleted message command (!verif) from ${msg.author.username} (NOT IN RIGHT CHANNEL)`)).catch(console.error); 
        return;

    }
    message.delete().then(msg => functionUtils.data.sendVerification(bot, bot.guilds.cache.get(bot.config.GUILD_ID).members.cache.get(msg.author.id)) && console.log(`Deleted message command (!verif) from ${msg.author.username}`)).catch(console.error);
}