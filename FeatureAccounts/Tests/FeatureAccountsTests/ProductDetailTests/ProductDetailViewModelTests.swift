//
//  File.swift
//  
//
//  Created by Connor Black on 27/09/2023.
//

import XCTest
import Foundation
import Networking
import SharedTestUtils
@testable import FeatureAccounts

final class ProductDetailViewModelTests: XCTestCase {
    var viewModel: ProductDetailViewModel!
    var dependenciesMock: ProductDetailDependenciesMock!
    var coordinatorMock: AccountsCoordinatorMock!
    var dataProviderMock: DataProviderMock!
    var moneyboxValueUpdated: (() -> Void)!
    
    override func setUp() {
        super.setUp()
        self.dataProviderMock = DataProviderMock()
        dependenciesMock = ProductDetailDependenciesMock()
        coordinatorMock = AccountsCoordinatorMock()
        viewModel = ProductDetailViewModel(
            dependencies: dependenciesMock,
            coordinator: coordinatorMock,
            parentAccount: .init(),
            product: .init(),
            moneyboxValueUpdated: { [weak self] in
                self?.moneyboxValueUpdated()
            }
        )
    }
    
    override func tearDown() {
        viewModel = nil
        dependenciesMock = nil
        coordinatorMock = nil
        moneyboxValueUpdated = nil
        super.tearDown()
    }
    
    /// Tests the behavior of the `addOneOffPayment` method in the `ProductDetailViewModel` when a one-off payment is successfully processed.
    /// This test ensures that:
    /// 1. The dependencies' `oneOffPaymentRequester` method is invoked with the correct parameters.
    /// 2. The `setIsLoading` callback toggles the loading state correctly.
    /// 3. The `newMoneyboxValueReceived` callback is invoked with the updated moneybox value.
    /// 4. The `moneyboxValueUpdated` handler is called to indicate that the moneybox value has been updated.
    ///
    /// The test follows these steps:
    /// - For setup, a mock successful response is created and set as the expected result for the `oneOffPaymentRequester` method in the dependencies mock.
    /// - The `addOneOffPayment` method of the view model is called with a specific amount.
    /// - Assertions are made to ensure that the dependencies' method is called with the expected parameters, the loading state is toggled correctly, the `newMoneyboxValueReceived` callback is invoked with the updated value, and the `moneyboxValueUpdated` handler is called.
    func test_oneOffPaymentFailure() {
        // GIVEN
        let mockError = EquatableError(
            NSError(
                domain: "Test",
                code: 123,
                userInfo: [NSLocalizedDescriptionKey: "Test Error Localized Description"]
            )
        )
        let result: Result<OneOffPaymentResponse, EquatableError> = .failure(mockError)
        dependenciesMock.oneOffPaymentResult = .failure(mockError)
        
        let loadingDidFinishExpectation = self.expectation(description: "One Off Payment did finish loading")
        var isLoadingInvocations: [Bool] = []
        viewModel.setIsLoading = { isLoading in
            isLoadingInvocations.append(isLoading)
            if !isLoading {
                loadingDidFinishExpectation.fulfill()
            }
        }
        
        // WHEN
        viewModel.addOneOffPayment(of: 10)
        waitForExpectations(timeout: 1)
        
        // THEN
        
        // Ensure that the dependencies class invokes the oneOffPayment request exactly once.
        let request = OneOffPaymentRequest(amount: 10, investorProductID: 123)
        let dependencyMockInvocations = dependenciesMock.methodCalls.filter {
            $0 == .invokeOneOffPaymentRequest(.init(input: .init(request), output: .init(result)))
        }
        XCTAssertEqual(dependencyMockInvocations.count, 1)
        // Ensure that setLoading is invoked exactly 2 times with the correct state.
        XCTAssertEqual([true, false], isLoadingInvocations)
        // Ensure that the coordinator calls displayErrorDialog exactly once.
        let coordinatorMockInvocations = coordinatorMock.methodCalls.filter { $0 == .displayErrorDialog(.init("Test Error Localized Description")) }
        XCTAssertEqual(coordinatorMockInvocations.count, 1)
    }
    
    /// Tests the behavior of the `addOneOffPayment` method in the `ProductDetailViewModel` when a one-off payment is successfully processed.
    /// This test ensures that:
    /// 1. The dependencies' `oneOffPaymentRequester` method is invoked with the correct parameters.
    /// 2. The `setIsLoading` callback toggles the loading state correctly.
    /// 3. The `newMoneyboxValueReceived` callback is invoked with the updated moneybox value.
    /// 4. The `moneyboxValueUpdated` handler is called to indicate that the moneybox value has been updated.
    ///
    /// The test follows these steps:
    /// - For setup, a mock successful response is created and set as the expected result for the `oneOffPaymentRequester` method in the dependencies mock.
    /// - The `addOneOffPayment` method of the view model is called with a specific amount.
    /// - Assertions are made to ensure that the dependencies' method is called with the expected parameters, the loading state is toggled correctly, the `newMoneyboxValueReceived` callback is invoked with the updated value, and the `moneyboxValueUpdated` handler is called.
    func test_oneOffPaymentSuccess() {
        // GIVEN
        let successResponse = OneOffPaymentResponse(moneybox: 1010)
        let result: Result<OneOffPaymentResponse, EquatableError> = .success(successResponse)
        dependenciesMock.oneOffPaymentResult = .success(successResponse)
        
        let loadingDidFinishExpectation = self.expectation(description: "One Off Payment did finish loading")
        var isLoadingInvocations: [Bool] = []
        viewModel.setIsLoading = { isLoading in
            isLoadingInvocations.append(isLoading)
            if !isLoading {
                loadingDidFinishExpectation.fulfill()
            }
        }
        
        var moneyboxValueUpdatedInvocations: [Bool] = []
        self.moneyboxValueUpdated = {
            moneyboxValueUpdatedInvocations.append(true)
        }
        
        var newMoneyboxValueReceivedInvocations: [Double?] = []
        viewModel.newMoneyboxValueReceived = { amount in
            newMoneyboxValueReceivedInvocations.append(amount)
        }
        
        // WHEN
        viewModel.addOneOffPayment(of: 10)
        waitForExpectations(timeout: 1)
        
        // THEN
        
        // Ensure that the dependencies class invokes the oneOffPayment request exactly once.
        let request = OneOffPaymentRequest(amount: 10, investorProductID: 123)
        let dependencyMockInvocations = dependenciesMock.methodCalls.filter {
            $0 == .invokeOneOffPaymentRequest(.init(input: .init(request), output: .init(result)))
        }
        XCTAssertEqual(dependencyMockInvocations.count, 1)
        // Ensure that setLoading is invoked exactly 2 times with the correct state.
        XCTAssertEqual([true, false], isLoadingInvocations)
        // Ensure that newMoneyboxValueReceived is invoked exactly once with the correct amount.
        XCTAssertEqual(newMoneyboxValueReceivedInvocations.count, 1)
        XCTAssertEqual(newMoneyboxValueReceivedInvocations[0], 1010)
        // Ensure that the viewModel calls the moneyboxValueUpdated handler exactly once.
        XCTAssertEqual([true], moneyboxValueUpdatedInvocations)
    }
        
}

fileprivate extension Account {
    init() {
        self.init(
            type: nil,
            name: nil,
            deepLinkIdentifier: nil,
            wrapper: nil,
            milestone: nil,
            hasCollections: nil
        )
    }
}

fileprivate extension ProductResponse {
    init() {
        self.init(
            id: 123,
            assetBoxGlobalID: nil,
            planValue: nil,
            moneybox: nil,
            subscriptionAmount: nil,
            totalFees: nil,
            isSelected: nil,
            isFavourite: nil,
            collectionDayMessage: nil,
            wrapperID: nil,
            isCashBox: nil,
            pendingInstantBankTransferAmount: nil,
            assetBox: nil,
            product: nil,
            investorAccount: nil,
            personalisation: nil,
            contributions: nil,
            moneyboxCircle: nil,
            isSwitchVisible: nil,
            state: nil,
            dateCreated: nil
        )
    }
}
