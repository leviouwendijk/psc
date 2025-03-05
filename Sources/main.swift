import Foundation
import ArgumentParser
import plate
import Economics

struct PurchaseSavingsCalculator: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Calculator for an expense based on your income and percentage.",
        subcommands: [Time.self, Percentage.self],
        defaultSubcommand: Time.self
    )
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
        let config = SavingsTarget.Configuration(target: price, income: income, rounding: true)
        let months = SavingsTarget.time(config: config, saveRate: saveRate)

        print()
        print(
            "It will take approximately "
            + "\(months)".ansi(.bold) 
            + " months to save "
            + "\(price) ".ansi(.bold) 
            + "at a "
            + "\(saveRate)% ".ansi(.bold) 
            + "savings rate."
        )
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
        let config = SavingsTarget.Configuration(target: price, income: income, rounding: true)
        let requiredRate = SavingsTarget.saverate(config: config, months: months)

        print()
        print(
            "You need to save "
            + "\(requiredRate)%".ansi(.bold) 
            + " of your income each month to reach "
            + "\(price) ".ansi(.bold) 
            + "in "
            + "\(months) ".ansi(.bold) 
            + "months."
        )
        print()
    }
}

PurchaseSavingsCalculator.main()
