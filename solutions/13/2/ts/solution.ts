import * as fs from 'fs';

function compare(left: any, right: any): number {
    if(typeof left === 'number' && typeof right === 'number') {
        return left - right;
    }

    if(typeof left == 'number') {
        return compare([left], right);
    }
    if(typeof right == 'number') {
        return compare(left, [right]);
    }

    const len = Math.min(left.length, right.length);
    for (let i = 0; i < len; i++) {
        var cmp = compare(left[i], right[i]);
        if (cmp != 0) {
            return cmp;
        }
    }
    return left.length - right.length
}

var packets = fs.readFileSync("cases/input/2").toString().split("\n").filter(Boolean).map(line => JSON.parse(line));

var packets = [...packets, [[2]], [[6]]];

packets.sort(compare)

var first = packets.findIndex(packet => compare(packet, [[2]]) == 0) + 1;
var second = packets.findIndex(packet => compare(packet, [[6]]) == 0) + 1;
console.log(first * second);