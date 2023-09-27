//
//  AccountsListViewModelTests.swift
//  
//
//  Created by Connor Black on 26/09/2023.
//

import XCTest
import Foundation
import Networking
import SharedTestUtils
@testable import FeatureAccounts

final class AccountsListViewModelTests: XCTestCase {
    var viewModel: AccountsListViewModel!
    var dependenciesMock: AccountsListDependenciesMock!
    var coordinatorMock: AccountsCoordinatorMock!
    var dataProviderMock: DataProviderMock!
    
    override func setUp() {
        super.setUp()
        self.dataProviderMock = DataProviderMock()
        let sessionMock = SessionManagerMock()
        dependenciesMock = AccountsListDependenciesMock(sessionManager: sessionMock)
        coordinatorMock = AccountsCoordinatorMock()
        viewModel = AccountsListViewModel(
            dependencies: dependenciesMock,
            coordinator: coordinatorMock
        )
    }
    
    override func tearDown() {
        viewModel = nil
        dependenciesMock = nil
        coordinatorMock = nil
        super.tearDown()
    }
    
    /// Tests the behavior of the `fetchProducts` method in the `AccountsListViewModel` when products are successfully fetched.
    /// This test ensures that:
    /// 1. The loading state is correctly toggled on and off.
    /// 2. The `onProductsFetchComplete` callback is invoked exactly once.
    /// 3. The dependencies' `fetchProducts` method is called with the expected successful result.
    /// 4. The ViewModel's stored response property is correctly populated.
    ///
    /// The test follows these steps:
    /// - For setup, a mock successful result is created and set as the expected result for the `fetchProducts` method in the dependencies mock.
    /// - The `fetchProducts` method of the view model is called.
    /// - Assertions are made to ensure that the loading state is toggled correctly, the completion callback is invoked, the dependencies' method is called with the expected successful result, and the ViewModel's stored response property is correctly populated.
    func test_fetchProductsSuccess() {
        // GIVEN
        var result: Result<AccountResponse, Error>!
        let expectation = self.expectation(description: "Result population expectation")
        dataProviderMock.fetchProducts { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(result)
        let equatableResult: Result<AccountResponse, EquatableError> = result.mapError({EquatableError($0)})
        dependenciesMock.fetchProductsResult = result
        
        let loadingDidFinishExpectation = self.expectation(description: "Product fetch finished loading")
        var isFetchingInvocations: [Bool] = []
        viewModel.setIsFetchingProducts = { isFetching in
            isFetchingInvocations.append(isFetching)
            if !isFetching {
                loadingDidFinishExpectation.fulfill()
            }
        }
        
        let onProductsFetchExpectation = self.expectation(description: "Product fetch completion")
        var onProductsFetchCompletedInvocations: [Bool] = []
        viewModel.onProductsFetchComplete = {
            onProductsFetchCompletedInvocations.append(true)
            onProductsFetchExpectation.fulfill()
        }
        
        // WHEN
        viewModel.fetchProducts()
        
        waitForExpectations(timeout: 1)
        
        // THEN
        // Ensure that loading is set 2 times, once for is loading and once for is not loading.
        XCTAssertEqual([true, false], isFetchingInvocations)
        // Ensure that onProductsFetchCompleted is called exactly one time
        XCTAssertEqual([true], onProductsFetchCompletedInvocations)
        // Ensure that the dependencies calls fetchProducts exactly once
        let dependencyMockInvocations = dependenciesMock.methodCalls.filter { $0 == .invokeFetchProducts(.init(equatableResult)) }
        XCTAssertEqual(dependencyMockInvocations.count, 1)
        // Ensure that the ViewModel stored response property equates to the mock result.
        XCTAssertNotNil(viewModel.response)
    }
    
    /// Tests the behavior of the `fetchProducts` method in the `AccountsListViewModel` when there's a failure in fetching products.
    /// This test ensures that:
    /// 1. The loading state is correctly toggled on and off.
    /// 2. The `onProductsFetchComplete` callback is invoked exactly once.
    /// 3. The dependencies' `fetchProducts` method is called with the expected error result.
    /// 4. The coordinator's `displayErrorDialog` method is invoked with the correct error message.
    ///
    /// The test follows these steps:
    /// - For setup, a mock error is created and set as the expected result for the `fetchProducts` method in the dependencies mock.
    /// - The `fetchProducts` method of the view model is called.
    /// - Assertions are made to ensure that the loading state is toggled correctly, the completion callback is invoked, the dependencies' method is called with the expected error, and the coordinator's error dialog is displayed with the correct message.
    func test_fetchProductsFailure() {
        // GIVEN
        let mockError = EquatableError(
            NSError(
                domain: "Test",
                code: 123,
                userInfo: [NSLocalizedDescriptionKey: "Test Error Localized Description"]
            )
        )
        let result: Result<AccountResponse, EquatableError> = .failure(mockError)
        dependenciesMock.fetchProductsResult = .failure(mockError)
        
        let loadingDidFinishExpectation = self.expectation(description: "Product fetch finished loading")
        var isFetchingInvocations: [Bool] = []
        viewModel.setIsFetchingProducts = { isFetching in
            isFetchingInvocations.append(isFetching)
            if !isFetching {
                loadingDidFinishExpectation.fulfill()
            }
        }
        
        let onProductsFetchExpectation = self.expectation(description: "Product fetch completion")
        var onProductsFetchCompletedInvocations: [Bool] = []
        viewModel.onProductsFetchComplete = {
            onProductsFetchCompletedInvocations.append(true)
            onProductsFetchExpectation.fulfill()
        }
    
        // WHEN
        viewModel.fetchProducts()
        
        waitForExpectations(timeout: 1)
        
        // THEN
        // Ensure that loading is set 2 times, once for is loading and once for is not loading.
        XCTAssertEqual([true, false], isFetchingInvocations)
        // Ensure that onProductsFetchCompleted is called exactly one time
        XCTAssertEqual([true], onProductsFetchCompletedInvocations)
        // Ensure that the dependencies calls fetchProducts exactly once
        let dependencyMockInvocations = dependenciesMock.methodCalls.filter { $0 == .invokeFetchProducts(.init(result)) }
        XCTAssertEqual(dependencyMockInvocations.count, 1)
        // Ensure that the coordinator calls displayErrorDialog exactly once
        let coordinatorMockInvocations = coordinatorMock.methodCalls.filter { $0 == .displayErrorDialog(.init("Test Error Localized Description")) }
        XCTAssertEqual(coordinatorMockInvocations.count, 1)
    }
    
    func test_logout() {
        // WHEN
        viewModel.logout()

        // THEN
        // Ensure that the coordinator calls displayLogoutDialog exactly once
        let coordinatorMockInvocations = coordinatorMock.methodCalls.filter { $0 == .displayLogoutDialog }
        XCTAssertEqual(coordinatorMockInvocations.count, 1)
    }
    
    /// Tests the behavior of the `handleProductTapped` method in the `AccountsListViewModel`.
    /// This test ensures that when a product is tapped:
    /// 1. The coordinator's `showProductDetail` method is invoked with the correct parameters.
    /// 2. The `showProductDetail` method is called exactly once.
    ///
    /// The test follows these steps:
    /// - For setup, mock data is set up to simulate a successful fetch of products, and the `fetchProducts` method of the view model is called to populate the data.
    /// - The `handleProductTapped` method is invoked with a specific product ID and account wrapper ID.
    /// - Assertions are made to ensure that the coordinator's method is called with the expected parameters.
    func test_handleProductTapped() {
        // GIVEN
        var accountResponse: AccountResponse!
        let expectation = self.expectation(description: "Result population expectation")
        dataProviderMock.fetchProducts { fetchedResult in
            switch fetchedResult {
            case .success(let success):
                accountResponse = success
            case .failure:
                XCTFail("Successful mock response expected.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(accountResponse)
        
        let productResponse = accountResponse.productResponses![0]
        let account = accountResponse.accounts![0]
        
        dependenciesMock.fetchProductsResult = .success(accountResponse)
        let onProductsFetchExpectation = self.expectation(description: "Product fetch completion")
        viewModel.onProductsFetchComplete = {
            onProductsFetchExpectation.fulfill()
        }
        viewModel.fetchProducts()
        waitForExpectations(timeout: 1)
        
        // WHEN
        viewModel.handleProductTapped(
            productId: productResponse.id!,
            accountWrapperId: productResponse.wrapperID!,
            moneyboxValueUpdated: {}
        )
        
        // THEN
        // Ensure that the coordinator calls showProductDetail exactly once
        let coordinatorMockInvocations = coordinatorMock.methodCalls.filter {
            $0 == .showProductDetail(
                Input(
                    .init(response: productResponse, account: account)
                )
            )
        }
        XCTAssertEqual(coordinatorMockInvocations.count, 1)
    }
}
