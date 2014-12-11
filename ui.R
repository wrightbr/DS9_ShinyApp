library(shiny)

# define UI 
shinyUI(fluidPage(
    
    # application title
    tags$h3("Sample size calculator for estimating a population proportion"),
    
    p("Say you want to estimate the proportion of likely voters that are going to vote for a given candidate (e.g., see this recent poll by ", tags$a(href="http://www.politico.com/p/polls/person/latest/hillary-clinton#.VImiWntRJZY", "Politico)"), ".  An obvious question is 'how many people should I ask'?  Less obvious questions are 'how confident do I want to be in my estimate' and 'how close to the true population value do I want to be'?  Next time you read an article citing an opinion poll, pay close attention to the answers to these questions.  Most credible polling organizations ususally say something like 'based on a survey of ", tags$i("X"), " voters, our poll had a margin of error of ", tags$i("Y"), " percentage points'. This app can be used to help you reproduce these claims or even design your own poll."),

    p("This Shiny app calculates the sample size ", tags$i("n"), " needed to estimate a population proportion " , tags$i("p"), " that has probability at least 1-\\(\\alpha\\) of being no farther than ", tags$i("d"), " from the true (unknown)  proportion.  The sample size equation (from 'Sampling' by S. K. Thompson, 1st ed.) is as follows:"),
    
    withMathJax(helpText("$$n=\\frac{Np(1-p)}{(N-1)\\frac{d^2}{z^2}+p(1-p)},$$")),
      
    p("where ", tags$i("z"), "is the upper \\(\\alpha\\)/2 point of the normal distribution.  If no estimate of ", tags$i("p"), " is available prior to the survey then a 'worst case' value of 0.5 can be used in determining sample size.  Result are provided for two cases:  1) when the sample size ", tags$i("n"), " is SMALL relative to the population size ", tags$i("N"), " (such as in a national poll), in which case the finite population correction can be ignored; and 2) when the sample size ", tags$i("n"), " is LARGE relative to the population size ", tags$i("N"), " (such as in a poll for a local school board), in which case the finite population correction is advantageous and results in a smaller sample size requirement."),
    
    tags$hr(),
        
    # Sidebar layout
    sidebarLayout(
        sidebarPanel(
            p("See what happens to the sample size requirement as you change the parameters below:"),
            hr(),
            sliderInput("alpha", p("\\(\\alpha\\) (1-\\(\\alpha\\) = confidence level)"), min = 0.01, max = 0.1, value = 0.05, step = 0.01),
            sliderInput("d", p(tags$i("d"), "  (margin of error)"), min = 0.01, max = 0.05, value = 0.03, step = 0.001),
            sliderInput("p", p(tags$i("p"), "  (population proportion)"), min = 0.1, max = 0.9, value = 0.5, step = 0.1),
            numericInput('N', p(tags$i("N"), "  (population size)"), value = 1000)
            
        ),
        
        # show result
        mainPanel(
            p("Sample size required when the sample is small relative to the population size"),
            verbatimTextOutput("sampleSize"),
            
            p("Sample size required when the sample is large relative to the population size"),
            verbatimTextOutput("sampleSizeFpc")
        )
    )
))