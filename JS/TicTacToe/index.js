function createBoard () {
  return {
    cells: [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    update: function () {
      console.log(`${this.cells[0]}   ${this.cells[1]}   ${this.cells[2]}     1   2   3`)
      console.log(`${this.cells[3]}   ${this.cells[4]}   ${this.cells[5]}     4   5   6`)
      console.log(`${this.cells[6]}   ${this.cells[7]}   ${this.cells[8]}     7   8   9`)
      this.initalizeDom()
    },
    initalizeDom: function () {
      for (let i = 1; i < 10; i++) {
        let className = `pos${i}`
        document.getElementsByClassName(className)[0].innerHTML = board.cells[i - 1]
      }
    },
    status: document.getElementById('status')
  }
}

let board = createBoard()
board.update()

addEventListener('DOMContentLoaded', () => {
  for (let i = 1; i < 10; i++) {
    let className = `pos${i}`
    document.getElementsByClassName(className)[0].innerHTML = board.cells[i - 1]
  }
})

function checkWin() {
  let tie = true;
  if (board.cells[0] !== ' ' && board.cells[0] == board.cells[1] && board.cells[1] == board.cells[2]) { return board.cells[0] }
  else if (board.cells[3] !== ' ' && board.cells[3] == board.cells[4] && board.cells[4] == board.cells[5]) { return board.cells[3] }
  else if (board.cells[6] !== ' ' && board.cells[6] == board.cells[7] && board.cells[7] == board.cells[8]) { return board.cells[6] }
  else if (board.cells[0] !== ' ' && board.cells[0] == board.cells[3] && board.cells[3] == board.cells[6]) { return board.cells[0] }
  else if (board.cells[1] !== ' ' && board.cells[1] == board.cells[4] && board.cells[4] == board.cells[7]) { return board.cells[1] }
  else if (board.cells[2] !== ' ' && board.cells[2] == board.cells[5] && board.cells[5] == board.cells[8]) { return board.cells[2] }
  else if (board.cells[0] !== ' ' && board.cells[0] == board.cells[4] && board.cells[4] == board.cells[8]) { return board.cells[0] }
  else if (board.cells[2] !== ' ' && board.cells[2] == board.cells[4] && board.cells[4] == board.cells[6]) { return board.cells[2] }
  for (let i = 0; i < board.cells.length; i++) {
    if (board.cells[i] === ' ') {
      tie = false;
      break;
    }
  }
  if (tie) return 'Tie'
  return false;
}

let createPlayer = (human, turn, symbol, name) => { return { human, turn, symbol, name } }
let players = [createPlayer(true, true, 'X', prompt("Player 1's name?")), createPlayer(true, true, 'O', prompt("Player 2's name?"))]
let i = 0
board.status.innerHTML = `(${players[0].symbol}) ${players[0].name}'s turn!`
function squareClicked(event) {
  const pos = event.target.classList[1].slice(3) // 1 - 9
  if (board.cells[pos - 1] !== ' ') {
    board.status.innerHTML = 'That square is already taken!'
    return;
  } else {
    board.cells[pos - 1] = players[i].symbol
  }
  board.update()
  const won = checkWin()
  if (won !== false) {
    if (won === 'Tie') {
      board.status.innerHTML = 'It\'s a tie!'
    } else {
      winner = players.filter(player => {
        return player.symbol === won
      })[0]
      board.status.innerHTML = `(${winner.symbol}) ${winner.name} wins!`
      document.getElementById('game').style.pointerEvents = 'none'
    }
    for (let j = 0; j < document.getElementsByClassName('game-square').length; j++) {
        document.getElementsByClassName('game-square')[j].style.backgroundColor = '#EBEBE4'
    }
  } else {
    i = (i === 0) ? 1 : 0
    board.status.innerHTML = `(${players[i].symbol}) ${players[i].name}'s turn!`
  }
}