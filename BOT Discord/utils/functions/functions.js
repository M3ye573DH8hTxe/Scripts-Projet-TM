var methods = {};

methods.setMemberNumber = function(bot){
    let myGuild = bot.guilds.cache.get(bot.config.GUILD_ID);
    let memberCount = myGuild.memberCount;
    let memberCountChannel = myGuild.channels.cache.get(bot.config.MEMBER_COUNT_CHANNEL);
    memberCountChannel.setName('Membres : ' + memberCount);
};

var steamServerStatus = require("steam-server-status");

methods.setPlayerConnected = function(bot) {
    steamServerStatus.getServerStatus(
        '178.33.255.15', 27340, function(serverInfo) {
            if (serverInfo.error) {
                console.log(serverInfo.error);
            } else {
                //console.log("game: " + serverInfo.gameName);
                //console.log("server name: " + serverInfo.serverName);
                //console.log("players: " + serverInfo.numberOfPlayers + "/" + serverInfo.maxNumberOfPlayers)
                bot.user.setActivity(serverInfo.numberOfPlayers + " joueurs en ligne.");
            }
    });
};

methods.sendVerification = function(bot, user) {

    const embed = {
        "title": "**Vérification | CitadelleRP**",
        "color": 359913,
        "timestamp": "2020-05-13T21:39:36.293Z",
        "footer": {
          "icon_url": "https://citadellerp.fr/images/icon.png",
          "text": "© CitadelleRP "
        },
        "thumbnail": {
          "url": "https://citadellerp.fr/images/icon.png"
        },
        "fields": [
          {
            "name": ":small_blue_diamond:  **Vérification pour être joueur :**",
            "value": "\n Pour recevoir le grade joueur et découvrir l'intégralité du discord, veuillez réagir, sous ce message, avec l'emoji 👍 \n "
          },
          {
            "name": ":small_blue_diamond:  **60 secondes :**",
            "value": "\n Vous avez 60 secondes pour réagir et recevoir votre rôle. Si vous n'avez pas eu le temps, veuillez bien faire un !verif dans le channel #vérification. Vous recevrez à nouveau un message privé. \n "
          }
        ]
      };
      
      console.log("Hello dude 1");
      user.send( { embed } ).then(r => id_embed = r.id && r.react('👍') && r.react('👎') && 

        r.awaitReactions((reaction, usere) => usere.id == user.id && (reaction.emoji.name == '👍' || reaction.emoji.name == '👎'), { max: 1, time: 60000 }).then(collected => {

          if (collected.first().emoji.name == '👍') {
                
                  user.send("Vous êtes désormais joueur.");
                  user.roles.add(bot.guilds.cache.get(bot.config.GUILD_ID).roles.cache.get(bot.config.ROLE_VERIFICATION));

              }else {user.send("Erreur de vérification...");}

            }).catch(() => {
                                
              user.send('Aucune réactoon après 60 secondes, opération annulée...');
        })

      );
            console.log("Hello dude 2");

} 
exports.data = methods;