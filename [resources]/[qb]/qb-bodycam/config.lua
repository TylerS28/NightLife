Config = {}

Config.webhook = "https://discord.com/api/webhooks/1056995482129420430/g4_O6LFbAI0G0DH0JbWtwFJ1_7DtN_B1ElUX811wm5_hF6NzJUtLKybxZn3X0A2LuCXm" --Your webhook address for the discord channel where the Bodycam recordings will be sent
 
Config.resolutions = "1080" -- or "1080p" , "480p" , "360p" /  Image quality of the video to be recorded.

Config.timeout = 30000 -- In milliseconds, the amount of seconds the video will be divided so that it does not exceed the Discord loading size

Config.bodycamitem = "bodycam" -- The name of the item you will use my body for
 
Config.command = "" --If you want to use a command key instead of the item, enter a command key , else = ""

Config.openui = "bcrecords" --Command to open the user interface to view recordings

Config.jobs = {"police" , "sheriff"}

Config.boss = "Chief of Police" -- The rank in which you will be authorized to delete records
