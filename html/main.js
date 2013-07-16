/*global ReadAlong */
window.addEventListener('load', function (e) {
    try {
        var args = {
            text_element: document.getElementById('passage-text'),
            audio_element: document.getElementById('passage-audio'),
            autofocus_current_word: false
        };

        if (!args.audio_element.canPlayType) {
            // No error messaging is needed because error message appears in <audio> fallback
            throw new Error('HTML5 Audio not supported');
        }
        if (args.audio_element.networkState === args.audio_element.NETWORK_NO_SOURCE) {
            document.querySelector('.passage-audio-unavailable').hidden = false;
            throw new Error('Cannot play any of the available sources');
        }



        ReadAlong.init(args);

        document.querySelector('.passage-audio').hidden = false;
    }
    catch (err) {
        console.error(err);
    }
    document.body.classList.add('initialized');
    document.querySelector('.loading').hidden = true;
}, false);
