// Public object
SockJS = (function(){
              var _document = document;
              var _window = window;
<!-- include lib/reventtarget.js -->
<!-- include lib/simpleevent.js -->
<!-- include lib/utils.js -->
<!-- include lib/sockjs.js -->
<!-- include lib/trans-websocket.js -->
<!-- include lib/trans-sender.js -->
<!-- include lib/trans-jsonp-receiver.js -->
<!-- include lib/trans-jsonp-polling.js -->
<!-- include lib/trans-xhr-streaming.js -->
<!-- include lib/trans-xhr-polling.js -->
<!-- include lib/trans-iframe.js -->
<!-- include lib/trans-iframe-within.js -->
<!-- include lib/chunking-test.js -->
<!-- include lib/trans-iframe-eventsource.js -->
<!-- include lib/trans-iframe-xhr-polling.js -->
<!-- include lib/trans-iframe-htmlfile.js -->
<!-- include lib/trans-polling.js -->
<!-- include lib/trans-receiver-eventsource.js -->
<!-- include lib/trans-receiver-htmlfile.js -->
<!-- include lib/trans-receiver-xhr.js -->
                  return SockJS;
          })();
if ('_sockjs_onload' in window) setTimeout(_sockjs_onload, 1);
