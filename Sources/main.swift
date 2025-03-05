import Foundation
import ArgumentParser
import plate

struct PurchaseSavingsCalculator: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Calculator for an expense based on your income and percentage.",
        subcommands: [Time.self, Percentage.self],
        defaultSubcommand: Time.self
    )

}

// extension Double: ExpressibleByArgument {
//     public init?(argument: String) {
//         if let doubleValue = Double(argument) {
//             self = doubleValue
//         } else {
//             return nil
//         }
//     }
// }

func calculateMonthsToSave(price: Double, income: Double, saveRate: Double) -> Int {
    let monthlySavings = (saveRate / 100) * income
    guard monthlySavings > 0 else { return Int.max } // Avoid division by zero
    return Int(ceil(price / monthlySavings))
}

func calculateRequiredSaveRate(price: Double, income: Double, months: Int) -> Double {
    guard months > 0, income > 0 else { return 0 } // Avoid division by zero
    return (price / (income * Double(months))) * 100
}

func formatOutput(_ value: Double, decimals: Int = 2) -> String {
    return String(format: "%.\(decimals)f", value)
}

struct Time: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "time",
        abstract: "Calculate the time it will take to reach savings goal."
    )

    @Argument(help: "The target price to calculate")
    var price: Double

    @Argument(help: "The average monthly income")
    var income: Double

    @Argument(help: "The percentage of earnings to be allocated for target")
    var saveRate: Double

    func run() throws {
        let months = calculateMonthsToSave(price: price, income: income, saveRate: saveRate)
        print()
        print(
            "It will take approximately "
            + "\(months)".ansi(.bold) 
            + " months to save "
            + "\(formatOutput(price)) ".ansi(.bold) 
            + "at a "
            + "\(formatOutput(saveRate))% ".ansi(.bold) 
            + "savings rate.")
        print()
    }
}

struct Percentage: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "percentage",
        abstract: "Calculate the percentage of earnings to allocate to meet price in set time."
    )

    @Argument(help: "The target price to calculate")
    var price: Double

    @Argument(help: "The average monthly income")
    var income: Double

    @Argument(help: "The number of months to save for target")
    var months: Int

    func run() throws {
        let requiredRate = calculateRequiredSaveRate(price: price, income: income, months: months)
        print()
        print(
            "You need to save "
            + "\(formatOutput(requiredRate))%".ansi(.bold) 
            + " of your income each month to reach "
            + "\(formatOutput(price)) ".ansi(.bold) 
            + "in "
            + "\(months) ".ansi(.bold) 
            + "months.")
        print()
    }
}

PurchaseSavingsCalculator.main()
