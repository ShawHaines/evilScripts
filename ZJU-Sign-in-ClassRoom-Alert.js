// ==UserScript==
// @name         浙江大学智云课堂签到提示 ZJU Sign-in ClassRoom Alert
// @namespace    https://github.com/ShawHaines/evilScripts/
// @version      0.1
// @description  search through the translated subtitles for specified key words in ZJU classroom(浙江大学智云课堂). Sends alert to you if it appears. if you are using chrome (or Edge with chrome core), allow `media autoplay` in settings in order to hear the alarm.
// @author       Shaw Haines
// @license      MIT
// @match        *://livingroom.cmc.zju.edu.cn/*
// @match        *://classroom.zju.edu.cn/*
// @grant        none
// @updateURL    https://github.com/ShawHaines/evilScripts/ZJU-Sign-in-ClassRoom-Alert.js
// @run-at       document-end
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    class keyWordListener{
        constructor(){
            this.queryString=window.prompt("Input query string","签到");
            this.oldLength=0;
            window.setInterval(this.listen.bind(this),1000); // monitor the subtitles every 1000 milisecond.
            console.log("Listener initiated.");
        };
        listen(){
            if (this.queryString===undefined) return 0;
            let a=document.querySelectorAll(".trans-item");
            var newLength=a.length;
            if (newLength>this.oldLength){
                for (let i=this.oldLength;i<newLength;i++){
                    let newText=a[i].innerText;
                    if (newText.search(this.queryString)!=-1){
                        // FIXME：if you are using chrome (or Edge with chrome core), allow `media autoplay` in settings in order to hear the alarm.
                        this.alertAudio(300,3);
                        window.alert("shit:"+this.queryString);
                    }
                    // console.log(newText);
                }
                this.oldLength=newLength;
                console.log(this.oldLength);
            }
            return newLength;
        };
       // plays audio at `frequency` and lasts for `duration`.
        alertAudio(frequency=196,duration=1){
            var audioCtx = new AudioContext();
            var oscillator = audioCtx.createOscillator();
            var gainNode = audioCtx.createGain();
            oscillator.connect(gainNode);
            gainNode.connect(audioCtx.destination);
            oscillator.type = 'sine';
            oscillator.frequency.value = frequency;
            // Set current volume to 0 first.
            gainNode.gain.setValueAtTime(0, audioCtx.currentTime);
            gainNode.gain.linearRampToValueAtTime(1, audioCtx.currentTime + 0.01);
            // start the sound
            oscillator.start(audioCtx.currentTime);
            // exponentially turn down the volume during 1 second.
            // gainNode.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + 1);
            // stop the sound after 1 second
            oscillator.stop(audioCtx.currentTime + duration);
        }
    }

    window.keywordListener=new keyWordListener();
})();
