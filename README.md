# Data-Processes-Project

## ERASMUS+ Mobility Program

Erasmus+ is the EU's program to support education, training, youth and sport in Europe. One of the main things it offers is the student and teaching staff exchange inside of the EU. More about the programme can be found [here](https://ec.europa.eu/programmes/erasmus-plus/node_en).

We have chosen to explore this domain since all of the contributors to this project are currently on their Erasmus exchange. Each one of us is familiar with the whole process and the choices to be made thus we would like to see it through data. It will be interesting to see how our decision and preference compare to other students from Europe.

### Related work

* Gender Gap in the ERASMUS Mobility Program ([link](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4762674/))
   + Project analyzes the mobility pattern within this program in 2011-12 to find a gender gap across countries and subject areas. Among other things it finds out that female students are over-represented in the ERASMUS program when compared to the entire population of tertiary students.

* Barriers to International Student Mobility Evidence From the Erasmus Program ([link](https://www.researchgate.net/publication/258134759_Barriers_to_International_Student_Mobility_Evidence_From_the_Erasmus_Program))
    + Project compares participants and nonparticipants to discover factors that support or limit student mobility. Results reveal the overall impact of financial barriers but suggest that it is personal barriers that help us to better differentiate between Erasmus and non-Erasmus students.
* Social and Economic Conditions of Student Life in Europe: Chapter 8. Internationalisation and student mobility ([link](https://books.google.es/books?id=E5EBLiBIFrEC&pg=PA130&lpg=PA130&dq=student+mobility+dataset+project&source=bl&ots=L4hMMvLoUQ&sig=ACfU3U1Lx9TTlmDVVE2E6r6tOK1hGRMjrQ&hl=hr&sa=X&ved=2ahUKEwicj_X51dXlAhVNXRoKHfYtCooQ6AEwCXoECAoQAQ#v=onepage&q=student%20mobility%20dataset%20project&f=false))
    + In this book chapter about student mobility can be found. It tries to answer general questions like most commonly destiniation, at what part of the studying students usually go on exchange, languages spoken etc.

### Questions

* **Q1:** For each country: Which countries are the most popular destinations? From which countries does it recieve the most students?
* **Q2:** Are there any tendecies in popularity of destinations? Which are the "hot" destinations? Can we predict a future "hot" destinaton?
* **Q3:** Is there a significant difference in the choice of destination depending on the area of the studies?

## Data
The only raw data that is available about the Erasmus+ mobility program is directly published by the European Union. They gather the data from the statistical reports of the national agencies of the 33 countries participating in the Erasmus+ program (Erasmus decentralised actions) and data provided by Education Audiovisual and Culture Executive Agency (Erasmus centralised actions). The data is generated during the application process of the student and then collected by the respective universites. Since all of the datasets are from the same source this explanation is valid for all of them. Furthermore we will use the three datasets for getting an insght into the chronological development. This means a question might be referenced more than once.

* Erasmus student mobility 2009-10 dataset
    + Data is available [here](https://data.europa.eu/euodp/de/data/dataset/erasmus-facts-figures-trends-2009-2010)
    + It contains 32 variables and 213385 observations
    + Will answer question:
      * **Q2:** Because we can evaluate the destination choices over time
      * **Q3:** Because it contains information about study programs and the destinations over time

* Erasmus student mobility 2011-12 dataset
    + Data is available [here](http://data.europa.eu/euodp/en/data/dataset/erasmus-mobility-statistics-2011-12)  
    + It contains 32 variables and 252827 observations
    + Will answer question:
      * **Q2:** v.s.
      * **Q3:** v.s.
    
* Erasmus student mobility 2013-14 dataset
    + Data is available [here](https://data.europa.eu/euodp/de/data/dataset/erasmus-mobility-statistics-2013-14)
    + It contains 27 variables and 272497 observations
    + Will answer question:
        * **Q1:** Because it contains information about origins and destinations. We use this dataset over ther others because it is the most recent one published.

