/**
 * gmajail — WebSocket terminal client
 * Connects xterm.js to the Gemma 4 backend with jailbreak aesthetics.
 */

(function () {
    const statusEl = document.getElementById('status');
    const term = new Terminal({
        cursorBlink: true,
        cursorStyle: 'block',
        fontFamily: "'Share Tech Mono', 'Courier New', monospace",
        fontSize: 15,
        theme: {
            background: '#0d0d0d',
            foreground: '#00ff41',
            cursor: '#00ff41',
            cursorAccent: '#0d0d0d',
            selectionBackground: 'rgba(0, 255, 65, 0.2)',
            black:   '#1a1a1a',
            red:     '#ff3333',
            green:   '#00ff41',
            yellow:  '#ffb000',
            blue:    '#00aaff',
            magenta: '#ff00ff',
            cyan:    '#00ffff',
            white:   '#b3b3b3',
            brightBlack:   '#333333',
            brightRed:     '#ff6666',
            brightGreen:   '#66ff66',
            brightYellow:  '#ffcc33',
            brightBlue:    '#66ccff',
            brightMagenta: '#ff66ff',
            brightCyan:    '#66ffff',
            brightWhite:   '#ffffff',
        },
        allowProposedApi: true,
        scrollback: 5000,
    });

    const fitAddon = new FitAddon.FitAddon();
    const webLinksAddon = new WebLinksAddon.WebLinksAddon();

    term.loadAddon(fitAddon);
    term.loadAddon(webLinksAddon);

    term.open(document.getElementById('terminal'));
    fitAddon.fit();

    window.addEventListener('resize', () => fitAddon.fit());

    function connect() {
        const protocol = location.protocol === 'https:' ? 'wss:' : 'ws:';
        const wsUrl = `${protocol}//${location.host}/ws`;
        statusEl.textContent = '🔌 Connecting...';
        statusEl.style.color = '#ffb000';

        const ws = new WebSocket(wsUrl);

        ws.onopen = () => {
            statusEl.textContent = '🔓 CONNECTED';
            statusEl.style.color = '#00ff41';
        };

        ws.onmessage = (event) => {
            term.write(event.data);
        };

        ws.onclose = () => {
            statusEl.textContent = '⚠️ DISCONNECTED';
            statusEl.style.color = '#ff3333';
            term.write('\r\n\x1b[1;31m[Connection lost. Reconnecting in 3s...]\x1b[0m\r\n');
            setTimeout(connect, 3000);
        };

        ws.onerror = () => {
            statusEl.textContent = '❌ ERROR';
            statusEl.style.color = '#ff3333';
        };

        term.onData((data) => {
            if (ws.readyState === WebSocket.OPEN) {
                ws.send(data);
            }
        });
    }

    connect();
})();
