var functionUtils = require("../utils/functions/functions.js")

module.exports = (bot, user) => {

    functionUtils.data.setMemberNumber(bot);
    functionUtils.data.sendVerification(bot, user);
    user.guild.channels.cache.get(bot.config.CHANNEL_LOGS).send('[🟢] **' + user.user.username + '**, a rejoins le serveur !'); 

};