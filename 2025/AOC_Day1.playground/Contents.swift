import Foundation

enum FilePart: String {
    case Input = "/Users/...input.txt"
    case Sample = "/Users/.../sample.txt"
}

struct Row {
    let dir:String
    let inc:Int
}

struct FileReader {
    func readFile(filename:String) -> [String] {
        do {
            let read = try String(contentsOfFile: filename, encoding: .utf8)
            return read.split(separator: "\n").map { String($0) }
        } catch {
            print(error)
            return []
        }
    }
}

struct PartOne {
    private var pos:Int
    private var zeroCount:Int
    init() {
        self.pos = 50
        self.zeroCount = 0
    }
    
    mutating func turnLeft(by:Int) -> Int {
        self.pos -= by
        if self.pos < 0 {
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func turnRight(by:Int) -> Int {
        self.pos += by
        if self.pos >= 100 {
            self.pos %= 100
        }
        return self.pos
    }
    
    //TODO: Implement filename default
    mutating func solve(filename:FilePart = .Sample) {
        let reader = FileReader()
        let input = reader.readFile(filename: filename.rawValue)
        var temp:Row = Row(dir: "L", inc: 0)
        for line in input {
            temp = Row(dir: line.first?.uppercased() ?? "L", inc: Int(line.dropFirst().lowercased())!)
            if temp.dir == "L" {
                turnLeft(by: temp.inc)
            } else if temp.dir == "R" {
                turnRight(by: temp.inc)
            }
            if self.pos == 0 {
                self.zeroCount += 1
            }
        }
        print(zeroCount)
    }
}

struct PartTwo {
    private var pos:Int
    private var zeroClickCount:Int
    
    init() {
        self.pos = 50
        self.zeroClickCount = 0
    }
    
    mutating func turnLeft(by:Int = 0) -> Int {
        self.pos -= by
        if self.pos < 0 {
            self.zeroClickCount += abs(Int(self.pos / 100))
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func turnRight(by:Int = 0) -> Int {
        self.pos += by
        if self.pos >= 100 {
            self.zeroClickCount += abs(Int(self.pos / 100))
            self.pos %= 100
        }
        return self.pos
    }
    
    mutating func solve(filename:FilePart = .Sample) {
        let reader = FileReader()
        let input = reader.readFile(filename: filename.rawValue)
        var temp:Row = Row(dir: "L", inc: 0)
        for line in input {
            temp = Row(dir: String(line.first!),
                       inc: Int(line.dropFirst())!)
            if temp.dir == "L" {
                print(line, turnLeft(by: temp.inc), zeroClickCount)
            } else if temp.dir == "R" {
                print(line, turnRight(by: temp.inc), zeroClickCount)
            }
        }
        print(self.zeroClickCount)
    }
}

print("Part One:")
var partOne = PartOne()
partOne.solve(filename: .Input)

print("\nPart Two:")
var partTwo = PartTwo()
partTwo.solve(filename: .Input)
