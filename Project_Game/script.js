let currentPlayer = 'X';
let cells = document.querySelectorAll('.cell');
let messageDisplay = document.getElementById('message');
let gameActive = true;

function cellClick(cellIndex) {
    if (!gameActive || cells[cellIndex].textContent !== '') return;

    cells[cellIndex].textContent = currentPlayer;
    checkGameResult();
    togglePlayer();
}

function togglePlayer() {
    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
}

function checkGameResult() {
    checkWinCondition();
    checkDrawCondition();
}

function checkWinCondition() {
    const winConditions = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ];

    for (let condition of winConditions) {
        let a = cells[condition[0]].textContent;
        let b = cells[condition[1]].textContent;
        let c = cells[condition[2]].textContent;

        if (a !== '' && a === b && b === c) {
            gameActive = false;
            messageDisplay.textContent = `Gracz ${currentPlayer} wygrywa!`;
            return;
        }
    }
}

function checkDrawCondition() {
    let isDraw = [...cells].every(cell => cell.textContent !== '');

    if (isDraw) {
        gameActive = false;
        messageDisplay.textContent = 'Remis!';
    }
}

function resetGame() {
    gameActive = true;
    currentPlayer = 'X';
    messageDisplay.textContent = '';
    cells.forEach(cell => cell.textContent = '');
}
