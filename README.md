## [ESX] Panic Button with menu osing ox_lib and ESX
### **[[DOWNLOAD](https://github.com/Puntzi/pnt_panicButton)]**
**[Preview](https://streamable.com/oyljiq)**

**FEATURES**

* Resmon 0.00ms
* Easely configurable

**Update 2.0**
* Now the blip it adds the player, that means the blip will follow the player until you disable it
* Fix a little bug you can open the menu without being a police 

**Requeriments**
* ESX
* ox_lib

**EXPORTS**
* You can use the exports if you want to add this to a radial menu or police menu (or edit the code)
```
exports['pnt_panicButton']:activateButton() -- This for activate the panic button
exports['pnt_panicButton']:openMenu() -- To open the panic button menu
```

**IMPORTANT**
* If you want to test the script alone you need to comment on line 19 this code:
```
and not (player.source == xPlayer.source)
```

***How to change the locale from my server?***
* To change the preferred language from English, add the convar to your server.cfg
```
setr ox:locale en
```


##### Any improve to the script just tell me and i will update it, feel free to do any pull request for code improve or anything :smiley:
