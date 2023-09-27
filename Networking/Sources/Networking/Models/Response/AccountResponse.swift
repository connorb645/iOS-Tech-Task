//
//  AccountResponse.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 17.01.2022.
//

import Foundation

// MARK: - AccountResponse
public struct AccountResponse: Codable, Equatable {
    public let moneyboxEndOfTaxYear: String?
    public let totalPlanValue: Double?
    public let totalEarnings: Double?
    public let totalContributionsNet: Double?
    public let totalEarningsAsPercentage: Double?
    public let productResponses: [ProductResponse]?
    public let accounts: [Account]?

    enum CodingKeys: String, CodingKey {
        case moneyboxEndOfTaxYear = "MoneyboxEndOfTaxYear"
        case totalPlanValue = "TotalPlanValue"
        case totalEarnings = "TotalEarnings"
        case totalContributionsNet = "TotalContributionsNet"
        case totalEarningsAsPercentage = "TotalEarningsAsPercentage"
        case productResponses = "ProductResponses"
        case accounts = "Accounts"
    }
}

// MARK: - Account
public struct Account: Codable, Equatable {
    public let type: String?
    public let name: String?
    public let deepLinkIdentifier: String?
    public let wrapper: Wrapper?
    public let milestone: Milestone?
    public let hasCollections: Bool?
    
    public init(type: String?,
         name: String?,
         deepLinkIdentifier: String?,
         wrapper: Wrapper?,
         milestone: Milestone?,
         hasCollections: Bool?
    ) {
        self.type = type
        self.name = name
        self.deepLinkIdentifier = deepLinkIdentifier
        self.wrapper = wrapper
        self.milestone = milestone
        self.hasCollections = hasCollections
    }

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case name = "Name"
        case deepLinkIdentifier = "DeepLinkIdentifier"
        case wrapper = "Wrapper"
        case milestone = "Milestone"
        case hasCollections = "HasCollections"
    }
}

// MARK: - Milestone
public struct Milestone: Codable, Equatable {
    public let initialStage: String?
    public let endStage: String?
    public let endStageID: Int?

    enum CodingKeys: String, CodingKey {
        case initialStage = "InitialStage"
        case endStage = "EndStage"
        case endStageID = "EndStageId"
    }
}

// MARK: - Wrapper
public struct Wrapper: Codable, Equatable {
    public let id: String?
    public let definitionGlobalID: String?
    public let totalValue: Double?
    public let totalContributions: Int?
    public let earningsNet: Double?
    public let earningsAsPercentage: Double?
    public let returns: Returns?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case definitionGlobalID = "DefinitionGlobalId"
        case totalValue = "TotalValue"
        case totalContributions = "TotalContributions"
        case earningsNet = "EarningsNet"
        case earningsAsPercentage = "EarningsAsPercentage"
        case returns = "Returns"
    }
}

// MARK: - Returns
public struct Returns: Codable, Equatable {
    public let simple: Double?
    public let lifetime: Double?
    public let annualised: Double?

    enum CodingKeys: String, CodingKey {
        case simple = "Simple"
        case lifetime = "Lifetime"
        case annualised = "Annualised"
    }
}

// MARK: - ProductResponse
public struct ProductResponse: Codable, Equatable {
    public let id: Int?
    public let assetBoxGlobalID: String?
    public let planValue: Double?
    public let moneybox: Double?
    public let subscriptionAmount: Int?
    public let totalFees: Double?
    public let isSelected: Bool?
    public let isFavourite: Bool?
    public let collectionDayMessage: String?
    public let wrapperID: String?
    public let isCashBox: Bool?
    public let pendingInstantBankTransferAmount: Int?
    public let assetBox: AssetBox?
    public let product: Product?
    public let investorAccount: InvestorAccount?
    public let personalisation: Personalisation?
    public let contributions: Contributions?
    public let moneyboxCircle: MoneyboxCircle?
    public let isSwitchVisible: Bool?
    public let state: String?
    public let dateCreated: String?
    
    public init(
        id: Int?,
        assetBoxGlobalID: String?,
        planValue: Double?,
        moneybox: Double?,
        subscriptionAmount: Int?,
        totalFees: Double?,
        isSelected: Bool?,
        isFavourite: Bool?,
        collectionDayMessage: String?,
        wrapperID: String?,
        isCashBox: Bool?,
        pendingInstantBankTransferAmount: Int?,
        assetBox: AssetBox?,
        product: Product?,
        investorAccount: InvestorAccount?,
        personalisation: Personalisation?,
        contributions: Contributions?,
        moneyboxCircle: MoneyboxCircle?,
        isSwitchVisible: Bool?,
        state: String?,
        dateCreated: String?
    ) {
        self.id = id
        self.assetBoxGlobalID = assetBoxGlobalID
        self.planValue = planValue
        self.moneybox = moneybox
        self.subscriptionAmount = subscriptionAmount
        self.totalFees = totalFees
        self.isSelected = isSelected
        self.isFavourite = isFavourite
        self.collectionDayMessage = collectionDayMessage
        self.wrapperID = wrapperID
        self.isCashBox = isCashBox
        self.pendingInstantBankTransferAmount = pendingInstantBankTransferAmount
        self.assetBox = assetBox
        self.product = product
        self.investorAccount = investorAccount
        self.personalisation = personalisation
        self.contributions = contributions
        self.moneyboxCircle = moneyboxCircle
        self.isSwitchVisible = isSwitchVisible
        self.state = state
        self.dateCreated = dateCreated
    }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case assetBoxGlobalID = "AssetBoxGlobalId"
        case planValue = "PlanValue"
        case moneybox = "Moneybox"
        case subscriptionAmount = "SubscriptionAmount"
        case totalFees = "TotalFees"
        case isSelected = "IsSelected"
        case isFavourite = "IsFavourite"
        case collectionDayMessage = "CollectionDayMessage"
        case wrapperID = "WrapperId"
        case isCashBox = "IsCashBox"
        case pendingInstantBankTransferAmount = "PendingInstantBankTransferAmount"
        case assetBox = "AssetBox"
        case product = "Product"
        case investorAccount = "InvestorAccount"
        case personalisation = "Personalisation"
        case contributions = "Contributions"
        case moneyboxCircle = "MoneyboxCircle"
        case isSwitchVisible = "IsSwitchVisible"
        case state = "State"
        case dateCreated = "DateCreated"
    }
}

// MARK: - AssetBox
public struct AssetBox: Codable, Equatable {
    public let title: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
    }
}

// MARK: - Contributions
public struct Contributions: Codable, Equatable {
    public let status: String?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
    }
}

// MARK: - InvestorAccount
public struct InvestorAccount: Codable, Equatable {
    public let contributionsNet: Double?
    public let earningsNet: Double?
    public let earningsAsPercentage: Double?
    public let todaysInterest: Double?

    enum CodingKeys: String, CodingKey {
        case contributionsNet = "ContributionsNet"
        case earningsNet = "EarningsNet"
        case earningsAsPercentage = "EarningsAsPercentage"
        case todaysInterest = "TodaysInterest"
    }
}

// MARK: - MoneyboxCircle
public struct MoneyboxCircle: Codable, Equatable {
    public let state: String?

    enum CodingKeys: String, CodingKey {
        case state = "State"
    }
}

// MARK: - Personalisation
public struct Personalisation: Codable, Equatable {
    public let quickAddDeposit: QuickAddDeposit?
    public let hideAccounts: HideAccounts?

    enum CodingKeys: String, CodingKey {
        case quickAddDeposit = "QuickAddDeposit"
        case hideAccounts = "HideAccounts"
    }
}

// MARK: - HideAccounts
public struct HideAccounts: Codable, Equatable {
    public let enabled: Bool?
    public let isHidden: Bool?
    public let sequence: Int?

    enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case isHidden = "IsHidden"
        case sequence = "Sequence"
    }
}

// MARK: - QuickAddDeposit
public struct QuickAddDeposit: Codable, Equatable {
    public let amount: Int?

    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
    }
}

// MARK: - Product
public struct Product: Codable, Equatable {
    public let id: Int?
    public let name: String?
    public let categoryType: String?
    public let type: String?
    public let friendlyName: String?
    public let canWithdraw: Bool?
    public let productHexCode: String?
    public let annualLimit: Int?
    public let depositLimit: Int?
    public let bonusMultiplier: Double?
    public let minimumWeeklyDeposit: Int?
    public let maximumWeeklyDeposit: Int?
    public let documents: Documents?
    public let state: String?
    public let wrapperDefinitionGlobalID: String?
    public let lisa: Lisa?
    public let interestRate: String?
    public let interestRateAmount: Double?
    public let logoURL: String?
    public let fund: Fund?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case categoryType = "CategoryType"
        case type = "Type"
        case friendlyName = "FriendlyName"
        case canWithdraw = "CanWithdraw"
        case productHexCode = "ProductHexCode"
        case annualLimit = "AnnualLimit"
        case depositLimit = "DepositLimit"
        case bonusMultiplier = "BonusMultiplier"
        case minimumWeeklyDeposit = "MinimumWeeklyDeposit"
        case maximumWeeklyDeposit = "MaximumWeeklyDeposit"
        case documents = "Documents"
        case state = "State"
        case wrapperDefinitionGlobalID = "WrapperDefinitionGlobalId"
        case lisa = "Lisa"
        case interestRate = "InterestRate"
        case interestRateAmount = "InterestRateAmount"
        case logoURL = "LogoUrl"
        case fund = "Fund"
    }
}

// MARK: - Documents
public struct Documents: Codable, Equatable {
    public let keyFeaturesURL: String?

    enum CodingKeys: String, CodingKey {
        case keyFeaturesURL = "KeyFeaturesUrl"
    }
}

// MARK: - Fund
public struct Fund: Codable, Equatable {
    public let fundID: Int?
    public let name: String?
    public let logoURL: String?
    public let isFundDMB: Bool?

    enum CodingKeys: String, CodingKey {
        case fundID = "FundId"
        case name = "Name"
        case logoURL = "LogoUrl"
        case isFundDMB = "IsFundDMB"
    }
}

// MARK: - Lisa
public struct Lisa: Codable, Equatable {
    public let maximumBonus: Int?

    enum CodingKeys: String, CodingKey {
        case maximumBonus = "MaximumBonus"
    }
}
