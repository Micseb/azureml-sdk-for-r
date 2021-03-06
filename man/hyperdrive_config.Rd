% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hyperdrive.R
\name{hyperdrive_config}
\alias{hyperdrive_config}
\title{Create a configuration for a HyperDrive run}
\usage{
hyperdrive_config(hyperparameter_sampling, primary_metric_name,
  primary_metric_goal, max_total_runs, max_concurrent_runs = NULL,
  max_duration_minutes = 10080L, policy = NULL, estimator = NULL)
}
\arguments{
\item{hyperparameter_sampling}{The hyperparameter sampling space.
Can be a \code{RandomParameterSampling}, \code{GridParameterSampling}, or
\code{BayesianParameterSampling} object.}

\item{primary_metric_name}{A string of the name of the primary metric
reported by the experiment runs.}

\item{primary_metric_goal}{The \code{PrimaryMetricGoal} object. This
parameter determines if the primary metric is to be minimized or
maximized when evaluating runs.}

\item{max_total_runs}{An integer of the maximum total number of runs
to create. This is the upper bound; there may be fewer runs when the
sample space is smaller than this value. If both \code{max_total_runs} and
\code{max_duration_minutes} are specified, the hyperparameter tuning experiment
terminates when the first of these two thresholds is reached.}

\item{max_concurrent_runs}{An integer of the maximum number of runs to
execute concurrently. If \code{NULL}, all runs are launched in parallel.
The number of concurrent runs is gated on the resources available in the
specified compute target. Hence, you need to ensure that the compute target
has the available resources for the desired concurrency.}

\item{max_duration_minutes}{An integer of the maximum duration of the
HyperDrive run. Once this time is exceeded, any runs still executing are
cancelled. If both \code{max_total_runs} and \code{max_duration_minutes} are specified,
the hyperparameter tuning experiment terminates when the first of these two
thresholds is reached.}

\item{policy}{The early termination policy to use. Can be either a
\code{BanditPolicy}, \code{MedianStoppingPolicy}, or \code{TruncationSelectionPolicy}
object. If \code{NULL} (the default), no early termination policy will be used.

The \code{MedianStoppingPolicy} with \code{delay_evaluation of = 5} is a good
termination policy to start with. These are conservative settings that can
provide 25%-35% savings with no loss on primary metric
(based on our evaluation data).}

\item{estimator}{The \code{Estimator} object.}
}
\value{
The \code{HyperDriveConfig} object.
}
\description{
The HyperDrive configuration includes information about hyperparameter
space sampling, termination policy, primary metric, estimator, and
the compute target to execute the experiment runs on.

To submit the HyperDrive experiment, pass the \code{HyperDriveConfig} object
returned from this method to \code{submit_experiment()}.
}
\examples{
\dontrun{
# Load the workspace
ws <- load_workspace_from_config()

# Get the compute target
compute_target <- get_compute(ws, cluster_name = 'mycluster')

# Define the primary metric goal
goal = primary_metric_goal("MAXIMIZE")

# Define the early termination policy
early_termination_policy = median_stopping_policy(evaluation_interval = 1L,
                                                  delay_evaluation = 5L)

# Create the estimator
est <- estimator(source_directory = '.',
                 entry_script = 'train.R',
                 compute_target = compute_target)

# Create the HyperDrive configuration
hyperdrive_run_config = hyperdrive_config(
                                   hyperparameter_sampling = param_sampling,
                                   primary_metric_name = 'accuracy',
                                   primary_metric_goal = goal,
                                   max_total_runs = 100,
                                   max_concurrent_runs = 4,
                                   policy = early_termination_policy,
                                   estimator = est)

# Submit the HyperDrive experiment
exp <- experiment(ws, name = 'myexperiment')
run = submit_experiment(exp, hyperdrive_run_config)
}
}
\seealso{
\code{submit_experiment()}
}
