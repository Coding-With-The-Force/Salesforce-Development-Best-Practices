/**
 * Created by gerry on 8/3/2020.
 */

public with sharing class Util_Error_Logger
{
	public static Error_Log__c insertNewErrorLog(Exception exceptionPassed, String className, String methodName)
	{
		Error_Log__c newError = new Error_Log__c();

		if(exceptionPassed != null)
		{
			newError.Line_Number__c = exceptionPassed.getLineNumber();
			newError.Error_Description__c = exceptionPassed.getMessage();
			newError.Stack_Trace__c = exceptionPassed.getStackTraceString();
		}

		newError.Class_Name__c = className;
		newError.Method__c = methodName;

		insert newError;

		return newError;
	}

	public static void insertErrorRecordDetails(List<Error_Record_Detail__c> errorRecordDetailList)
	{
		Database.insert(errorRecordDetailList);
	}

	public static Error_Record_Detail__c createErrorRecordDetail(Id logId, Database.Error err, String recordId)
	{
		Error_Record_Detail__c errorDetail = new Error_Record_Detail__c();
		errorDetail.Error_Log__c = logId;
		errorDetail.Record_Id__c = recordId;
		errorDetail.Error_Messages__c = err.getMessage();
		errorDetail.Status_Code__c = String.valueOf(err.getStatusCode());
		return errorDetail;
	}
}