/**
 * Created by MRD433 on 9/17/2019.
 */
@isTest
public with sharing class Process_Builder_Terminator_Test
{
	public static testMethod void terminateProcessBuilder_Test()
	{
		Test.startTest();
			Process_Builder_Terminator.terminateProcessBuilder();
		Test.stopTest();
	}
}