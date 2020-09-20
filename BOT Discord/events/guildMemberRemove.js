var functionUtils = require("../utils/functions/functions.js")

module.exports = (bot, user) => {

    functionUtils.data.setMemberNumber(bot);
    user.guild.channels.cache.get(bot.config.CHANNEL_LOGS).send('[🔴] **' + user.user.username + '**, a quitté le serveur !'); 

};