import * as fs from 'fs';
import * as rd from 'readline';

var reader = rd.createInterface(fs.createReadStream("cases/input/2"));

function compare(left: Number|Number[], right: Number|Number[]): Number {
    if(typeof left === 'number' && typeof right === 'number') {
        return left - right;
    }

    if(typeof left == 'number') {
        return compare([left], right);
    }
    if(typeof right == 'number') {
        return compare(left, [right]);
    }

    left = <Number[]>left;
    right = <Number[]>right;

    const len = Math.min(left.length, right.length);
    for (let i = 0; i < len; i++) {
        var cmp = compare(left[i], right[i]);
        if (cmp != 0) {
            return cmp;
        }
    }
    return left.length - right.length
}

var solution = 0;
var i = 0;
var left: Number|Number[]|null = null;
var right: Number|Number[]|null = null;
reader.on("line", (l: string) => {
    if (l == "") {
        i++;
        if (compare(left!, right!) < 0) {
            solution += i;
        }
        left = right = null;
        return;
    }

    if (!left) {
        left = JSON.parse(l);
    } else {
        right = JSON.parse(l);
    }

});

reader.on("close", () => console.log(solution));