/**
 * @description This utility class is intended to become a single point (where appropriate) for DML operations to occur.
 * The primary purpose of this is to ensure proper logging, error handling and reduction in code duplication.
 *
 *@author Matt Gerry matt.e.gerry@accenturefederal.com
 *@date 7/13/2020
 */

public with sharing class Util_DML_Operations
{
	private static final String SUCCESS = 'Success';

	/**
     * @description  Takes list of SObjects and attempts an "AllOrNone = true" (default operation) delete operation.
     * @example deleteOperationAllOrNone(SObjectListToDelete, 'theCallingClass', 'theCallingMethod'
     * @return String
     */
	public String deleteOperationAllOrNone(List<SObject> deletionList, String callingClass, String callingMethod)
	{
		try
		{
			database.delete(deletionList);
			return SUCCESS;
		}
		catch(Exception except)
		{
			Util_Error_Logger.insertNewErrorLog(except, callingClass, callingMethod);
			return except.getMessage();
		}
	}

	/**
     * @description  Takes list of SObjects and attempts an "AllOrNone = false" delete operation.
     * @example deleteOperationAllOrNoneFalse(SObjectListToDelete, 'theCallingClass', 'theCallingMethod'
     * @return string
     */
	public String deleteOperationAllOrNoneFalse(List<SObject> deletionList, String callingClass, String callingMethod)
	{
		System.debug('DeletionList: ' + deletionList);
		Database.DeleteResult[] deleteResult = database.delete(deletionList, false);
		String result = processDeleteResult(deleteResult, callingClass, callingMethod);
		return result;
	}

	/**
     * @description  Takes list of SObjects and attempts an "AllOrNone = true" (default operation) insert operation.
     * @example insertOperationAllOrNone(SObjectListToDelete, 'theCallingClass', 'theCallingMethod'
     * @return string
     */
	public String insertOperationAllOrNone(List<SObject> insertionList, String callingClass, String callingMethod)
	{
		try
		{
			database.insert(insertionList);
			return SUCCESS;
		}
		catch(Exception except)
		{
			Util_Error_Logger.insertNewErrorLog(except, callingClass, callingMethod);
			return except.getMessage();
		}
	}

	/**
     * @description  Takes list of SObjects and attempts an "AllOrNone = false" insert operation.
     * @example insertOperationAllOrNoneFalse(SObjectListToDelete, 'theCallingClass', 'theCallingMethod'
     * @return string
     */
	public String insertOperationAllOrNoneFalse(List<SObject> insertionList, String callingClass, String callingMethod)
	{
		Database.SaveResult[] saveResults = Database.insert(insertionList, false);
		String result = processSaveResult(saveResults, callingClass, callingMethod);
		return result;
	}

	/**
	* @description  Takes list of SObjects and attempts an "AllOrNone = false" update operation.
 	* @example updateOperationAllOrNone(SObjectListToDelete, 'theCallingClass', 'theCallingMethod'
 	* @return string
 	*/
	public String updateOperationAllOrNone(List<SObject> updateList, String callingClass, String callingMethod)
	{
		try
		{
			database.update(updateList);
			return SUCCESS;

		}
		catch(Exception except)
		{
			Util_Error_Logger.insertNewErrorLog(except, callingClass, callingMethod);
			return except.getMessage();
		}
	}

	/**
	* @description  Takes list of SObjects and attempts an "AllOrNone = false" update operation.
 	* @example updateOperationAllOrNoneFalse(SObjectListToDelete, 'theCallingClass', 'theCallingMethod'
 	* @return string
 	*/
	public String updateOperationAllOrNoneFalse(List<SObject> updateList, String callingClass, String callingMethod)
	{
		Database.SaveResult[] saveResults = Database.insert(updateList, false);
		String result = processSaveResult(saveResults, callingClass, callingMethod);
		return result;
	}

	/**
	* @description  Takes a SaveResult aggregation and processes the results whether success of failure, including logging any errors
 	* @example processSaveResult(saveResultObject, 'The Calling Class', 'The Calling Method')
 	* @return string
 	*/
	private String processSaveResult(Database.SaveResult[] saveResults, String callingClass, String callingMethod)
	{
		String returnMessage = SUCCESS;
		List<Error_Record_Detail__c> errorRecordDetailsList = new List<Error_Record_Detail__c>();
		Error_Log__c loggedError = new Error_Log__c();

		Boolean insertParentError = true;

		for (Database.SaveResult saveResult : saveResults)
		{
			if (!saveResult.isSuccess())
			{
				String errorMessages = '';

				if(insertParentError)
				{
					loggedError = Util_Error_Logger.insertNewErrorLog(null, callingClass, callingMethod);
					insertParentError = false;
				}

				for (Database.Error error : saveResult.getErrors())
				{
					System.debug('DML Err: ' + String.valueOf(error.getStatusCode()) + ' ' + error.getMessage().left(99));
					errorRecordDetailsList.add(Util_Error_Logger.createErrorRecordDetail(loggedError.Id, error, saveResult.getId()));
					errorMessages += ' ' + error.getMessage();
				}

				returnMessage = errorMessages;
			}
		}

		Util_Error_Logger.insertErrorRecordDetails(errorRecordDetailsList);

		return returnMessage;
	}

	/**
	* @description  Takes a DeleteResult aggregation and processes the results whether success of failure, including logging any errors
 	* @example processDeleteResult(deleteResultObject, 'The Calling Class', 'The Calling Method')
 	* @return string
 	*/
	private String processDeleteResult(Database.DeleteResult[] deleteResults, String callingClass, String callingMethod)
	{
		String returnMessage = SUCCESS;
		List<Error_Record_Detail__c> errorRecordDetailsList = new List<Error_Record_Detail__c>();
		Error_Log__c loggedError = new Error_Log__c();

		Boolean insertParentError = true;

		for (Database.DeleteResult deleteResult : deleteResults)
		{
			if (!deleteResult.isSuccess())
			{
				String errorMessages = '';

				if(insertParentError)
				{
					loggedError = Util_Error_Logger.insertNewErrorLog(null, callingClass, callingMethod);
					insertParentError = false;
				}

				for (Database.Error error : deleteResult.getErrors())
				{
					errorRecordDetailsList.add(Util_Error_Logger.createErrorRecordDetail(loggedError.Id, error, deleteResult.getId()));
					errorMessages += ' ' + error.getMessage();
				}
				returnMessage = errorMessages;
			}
		}

		Util_Error_Logger.insertErrorRecordDetails(errorRecordDetailsList);

		return returnMessage;
	}
}
