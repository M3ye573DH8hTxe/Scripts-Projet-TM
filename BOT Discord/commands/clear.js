exports.run = (bot, message, args) => {

    if(message.member.hasPermission('MANAGE_MESSAGES')){

        let args = message.content.trim().split(/ +/g);

        if(args[1]){
            if(!isNaN(args[1]) && args[1] >= 1 && args[1] <= 99){

                message.channel.bulkDelete(1)
                message.channel.bulkDelete(args[1])
                
            }
            else{
                message.channel.send(`Vous devez indiquer une valeur entre 1 et 99 !`)
            }
        }
        else{
            message.channel.send(`Vous devez indiquer un nombre de messages a supprimer !`)
        }
    }
    else{
        message.channel.bulkDelete(1)
    }
};