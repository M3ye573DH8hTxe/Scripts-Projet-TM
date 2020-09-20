exports.run = (bot, message, args) => {

    message.delete().then(msg => console.log(`Deleted message command (!restart) from ${msg.author.username}`)).catch(console.error);

    if(message.author.id !== "193043383759929354") { return; } // Titan ID

    
    const embed = {
        "title": "**Arrêt du BOT | CitadelleRP**",
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
            "name": ":small_blue_diamond:  **Arrêt du BOT :**",
            "value": "\n Pour éteindre le BOT, veuillez cliquer sur le pouce en l´air. \n "
          }
        ]
      };

      message.channel.send({ embed }).then(r => id_embed = r.id && r.react('✅') && r.react('❌') && 

      r.awaitReactions((reaction, user) => user.id == message.author.id && (reaction.emoji.name == '✅' || reaction.emoji.name == '❌'), { max: 1, time: 30000 }).then(collected => {
          if (collected.first().emoji.name == '✅') {
              message.reply('Arrêt du BOT...');
                  bot.destroy();
              }else
                  message.reply('Opération annulée...');
          }).catch(() => {
                              
              message.reply('Aucune réactoon après 30 secondes, opération annulée...');
      })

    );

}