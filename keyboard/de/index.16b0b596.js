!function(){const e={CapsLock:"",Backquote:"`~àÀ",Digit1:"1!1!",Digit2:"2@2â",Digit3:"3#3î",Digit4:"4$4û",Digit5:"5%5ô",Digit6:"6^6ë",Digit7:"7&7ù",Digit8:"8*8ï",Digit9:"9(9(",Digit0:"0)0)",Minus:"-_ßÖ",Equal:"+=êÊ",KeyQ:"qQqQ",KeyW:"wWwW",KeyE:"eEeE",KeyR:"rRrR",KeyT:"tTtT",KeyY:"yYyY",KeyU:"uUuU",KeyI:"iIiI",KeyO:"oOoO",KeyP:"pPpP",BracketLeft:"[{üÜ",BracketRight:"]}èÈ",Backslash:"\\|çÇ",KeyA:"aAaA",KeyS:"sSsS",KeyD:"dDdD",KeyF:"fFfF",KeyG:"gGgG",KeyH:"hHhH",KeyJ:"jJjJ",KeyK:"kKkK",KeyL:"lLlL",Semicolon:";:ö:",Quote:'\'"ä"',KeyZ:"zZzZ",KeyX:"xXxX",KeyC:"cCcC",KeyV:"vVvV",KeyB:"bBbB",KeyN:"nNnN",KeyM:"mMmM",Comma:",<,Ä",Period:".>.É",Slash:"/?é?",IntlBackslash:"€°œæ"},t=document.querySelector("#CapsLock"),i=document.querySelector("#Text");i.addEventListener("keydown",(i=>{t.checked=i.getModifierState("CapsLock");const y=t.checked?2:0;let c=i.code;if(!(c in e))return;if(i.altKey||i.ctrlKey)return;i.preventDefault();const n=i.shiftKey?1:0;if(c=e[i.code][n+y],void 0===c)return;const o=i.target.selectionStart,K=i.target.selectionEnd,a=i.target.value;i.target.value=`${a.slice(0,o)}${c}${a.slice(K)}`,i.target.selectionStart=o+1,i.target.selectionEnd=o+1})),i.dispatchEvent(new KeyboardEvent("keydown",{code:"End"})),i.dispatchEvent(new KeyboardEvent("keydown",{code:"End"}))}();