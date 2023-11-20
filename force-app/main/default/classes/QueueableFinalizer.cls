public class QueueableFinalizer implements Finalizer{

    public void execute(FinalizerContext fc){
        switch on fc.getResult(){
            when SUCCESS{
                system.debug('Job Completed:: Job ID:: '+fc.getAsyncApexJobId());
            }
            when UNHANDLED_EXCEPTION{
                system.debug('Error In Job:: '+fc.getAsyncApexJobId());
                system.debug('Error Message:: '+fc.getException().getMessage());
            }
        }
    }
}