!function(){var e={Tab:" ",Backquote:"юЮюЮ",Digit1:"°!1!",Digit2:"әӘ2@",Digit3:"іІ3#",Digit4:"ңҢ4$",Digit5:"ғҒ5%",Digit6:"₽€6№",Digit7:"₸№7€",Digit8:"үҮ8*",Digit9:"ұҰ9(",Digit0:"қҚ0)",Minus:"өӨ-_",Equal:"һҺ+=",KeyQ:"яЯяЯ",KeyW:"ыЫыЫ",KeyE:"еЕеЕ",KeyR:"рРрР",KeyT:"тТтТ",KeyY:"йЙйЙ",KeyU:"уУуУ",KeyI:"иИиИ",KeyO:"оОоО",KeyP:"пПпП",BracketLeft:"шШшШ",BracketRight:"щЩщЩ",Backslash:"эЭэЭ",KeyA:"аАаА",KeyS:"сСсС",KeyD:"дДдД",KeyF:"фФфФ",KeyG:"гГгГ",KeyH:"хХхХ",KeyJ:"жЖжЖ",KeyK:"кКкК",KeyL:"лЛлЛ",Semicolon:";:;:",Quote:'ъ"ъ"',KeyZ:"зЗзЗ",KeyX:"чЧчЧ",KeyC:"цЦцЦ",KeyV:"вВвВ",KeyB:"бБбБ",KeyN:"нНнН",KeyM:"мМмМ",Comma:",Ъ,Ъ",Period:".Ь.Ь",Slash:"ь?ь?",IntlBackslash:"¥£ёЁ"},t=0,c=!1;document.querySelector("#AltGr").addEventListener("change",(function(e){t=e.target.checked?2:0,c=e.shiftKey})),document.querySelector("#Text").addEventListener("keydown",(function(i){var y=document.querySelector("#AltGr"),a=i.code;if(a in e&&!i.altKey&&!i.ctrlKey){if(i.preventDefault(),"Tab"===a)return y.checked=!y.checked,t=y.checked?2:0,void(c=i.shiftKey);var K=i.shiftKey?1:0,n=i.target.selectionStart,r=i.target.selectionEnd,o=i.target.value;a=e[i.code][K+t],i.target.value="".concat(o.slice(0,n)).concat(a).concat(o.slice(r)),i.target.selectionStart=n+1,i.target.selectionEnd=n+1,!c&&y.checked&&(y.checked=!1,t=0)}}))}();