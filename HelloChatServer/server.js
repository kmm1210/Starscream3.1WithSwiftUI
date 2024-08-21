// server.js
const WebSocket = require('ws');

const server = new WebSocket.Server({ port: 8080 });

server.on('connection', socket => {
    console.log('Client connected');
    
    socket.on('message', message => {
        console.log(`Received: ${message}`);
        // 메시지를 모든 클라이언트에 브로드캐스트
        server.clients.forEach(client => {
            if (client !== socket && client.readyState === WebSocket.OPEN) { 
                //client !== socket는 현재 메시지를 수신한 WebSocket 클라이언트와 메시지를 보내려는 WebSocket 클라이언트를 비교하는 조건
                console.log(`Sending mestsage to client: ${message}`); // 메시지 전송 로그 추가
                client.send(message); // 문자열 데이터 전송
            }
        });
    });

    socket.on('close', () => {
        console.log('Client disconnected');
    });
});

console.log('WebSocket server is running on ws://localhost:8080');
//node server.js로 시작