var functionUtils = require("../utils/functions/functions.js")

module.exports = (bot) => {

    console.log(`Le BOT ${bot.user.tag} s'est connecté.`);

    functionUtils.data.setMemberNumber(bot)
    functionUtils.data.setPlayerConnected(bot)

};