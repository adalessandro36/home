 Description 'Teenage Friends and Lifestyle Study' data

The data provided here belong to the older of the two student cohorts in this study, which were followed over their second, third and fourth year at a secondary school in Glasgow. The study was funded by the Chief Scientist Office of the Scottish Home and Health Department under their Smoking Initiative (grant K/OPR/17/8), and was executed by Lynn Michell and Patrick West of the Medical Research Council / Medical Sociology Unit, University of Glasgow. An excerpt of this data set is the s50 dataset, containing information about 50 girls from the Teenage Friends and Lifestyle Study.

Download the data set.
Download the questionnaire.

Background

The Teenage Friends and Lifestyle Study (Bush, West & Michell 1997, Michell and West 1996, Pearson and Michell 2000, Pearson and West 2003) aimed to identify processes by which attitudes towards smoking and smoking behaviour itself change over early to mid adolescence, focusing particularly on the stage of experimentation, and the transition from experimental to regular smoking. Data were recorded at three time points and for two cohorts. The data you can download on this page belong to the older cohort. Students were followed over a two year period starting in February 1995, when the pupils were aged 13, and ending in January 1997. A total of 160 pupils were part of this older cohort, 129 of whom were present at all three measurement points. The friendship networks were formed by allowing the pupils to name up to six friends. Pupils were also asked about elements of their lifestyle, including substance use and leisure activities. The school was representative of others in the region in terms of social class composition (Bush, West & Michell 1997). Qualitative data collected in the same study are reported by Michell (1997a, 1997b); Michell & West (1996); Michell & Amos (1997).

Coding

All data are in R format and can be directly loaded into the R workspace using the command "load", e.g., "load('Glasgow-friendship.RData')", assuming that this file in the current working directory. After having loaded these data, the command "ls()" or, equivalently, "objects()", lists all objects in the workspace of your R session, thus showing you the names of the variables included in these data sets.

For the exact wording of questions, please consult the questionnaire.

    file Glasgow-friendship.RData contains the three friendship networks in the adjacency matrices friendship.1, friendship.2, and friendship.3, for measurement points 1, 2, and 3, respectively. The data are valued; code 1 stands for "best friend", code 2 for "just a friend", and code 0 for "no friend". Code 10 indicates structural absence of the tie, i.e., at least one of the involved students was not yet part of the school cohort, or had already left the school cohort at the given time point

    file Glasgow-demographic.RData contains the two variables sex.F and age. The sex information is coded 1 for boys and 2 for girls. Age refers to the students' age on January 1st, 1995, and is coded in years with one decimal digit, recoded from original data about birth dates.

    file Glasgow-substances.RData contains the three substance use variables alcohol, tobacco and cannabis.
        Alcohol consumption is coded as follows: 1 (non), 2 (once or twice a year), 3 (once a month), 4 (once a week) and 5 (more than once a week);
        Tobacco use has the scores 1 (non), 2 (occasional) and 3 (regular, i.e. more than once per week).
        Cannabis use is coded 1 (non), 2 (tried once), 3 (occasional) and 4 (regular).

    The three variables are in matrix shape, with three columns corresponding to the three measurement points.

    file Glasgow-various.RData contains the three variables money, romantic and familysmoking.
        money is a matrix of three columns (one per measurement point) indicating how much pocket money the student had per moth, in British pounds;
        romantic indicates whether the student had a romantic relation (1=no, 2=yes) at the three measurement points.
        familysmoking contains three different variables in three columns: smoking at home, smoking by at least one parent, and smoking by at least one sibling. They are binary coded (1=no, 2=yes). While measured at all three time points, they barely showed any change over time. This variable contains for each student the first non-missing value on the given variable.

    file Glasgow-lifestyle.RData contains the three measurements of the variables music taste and leisure activities.
        files music1, music2, and music3 contain, in 16 columns, students' listening to any of 16 music styles (0=no, 1=yes);
        files leisure1, leisure2, and leisure3 contain, in 15 columns, the frequency at which students participated in any of 15 leisure activities (1=most days, 2=once a week, 3=once a month, 4=less often or never).

    file Glasgow-geographic.RData contains the following geographical information, obtained by recoding of postcode information:
        variable dist.school, a matrix containing in three columns the beeline distances between students' homes and the school building, in kilometres, at the three measurement points;
        variables distance.1, distance.2, and distance.3, dyadic variables containing the beeline distance between two students' homes, in kilometres, at measurement points 1, 2, and 3, respectively;
        variables angle.1, angle.2, and angle.3, dyadic variables containing the angle between the lines connecting two students' homes with the school, in radian measure, at measurement points 1, 2, and 3, respectively.
    The file Documentation-Postcodes.pdf gives the background and further information about these geographic variables.

    file Glasgow-selections.RData contains the two boolean indicator variables selection129 and selection50 that identify subsets of the data analysed in earlier publications.
        variable selection129 identifies the students present at all three measurement times; the papers by Pearson, Steglich & Snijders (2006), Steglich, Snijders & West (2006), and Snijders, Steglich & Schweinberger (2007) analyse this subset;
        variable selection50 identifies the 50 girls of the s50 dataset that has been distributed for illustrative purposes together with the SIENA software since 2004.

    The data analysed in early papers (including the s50 dataset) differ slightly from the current richer and better-screened release. The main discrepancy is the censoring of the first measurement point's name generator to six nominations that now was introduced to obtain consistency over time. In the first round of data collection, respondents had the option to request a second questionnaire for nominating up to six more network partners; this option was hardly made use of and was dropped at later measurement points.

References

    Bush, H., P. West, and L. Michell (1997). The role of friendship groups in the uptake and maintenance of smoking amongst pre-adolescent and adolescent children: Distribution of Frequencies. Working Paper No. 62. MRC Medical Sociology Unit Glasgow.
    Michell, L. (1997a). Pressure groups: young people's accounts of peer pressure to smoke. Social Sciences in Health, 3, 3-17.
    Michell, L. (1997b). Loud, sad or bad: young people's perceptions of peer groups and smoking. Health Education Research, 12(1), 1-14.
    Michell, L., and A. Amos (1997). Girls, pecking order and smoking. Social Science and Medicine, 44, 1861-1869.
    Michell, L., and P. West (1996). Peer pressure to smoke: the meaning depends on the method. Health Education Research, 11(1), 39-49.
    Pearson, M., and L. Michell. 2000. Smoke Rings: Social network analysis of friendship groups, smoking and drug-taking. Drugs: education, prevention and policy, 7, 21-37.
    Pearson, M., and P. West. 2003. Drifting Smoke Rings: Social Network Analysis and Markov Processes in a Longitudinal Study of Friendship Groups and Risk-Taking. Connections, 25(2), 59-76.
    Pearson, M., Ch. Steglich, and T.A.B. Snijders (2006). Homophily and assimilation among sport-active adolescent substance users. Connections 27(1), 47-63.
    Steglich, Ch., T.A.B. Snijders, and M. Pearson (2010). Dynamic Networks and Behavior: Separating Selection from Influence. Sociological Methodology, 329-393. DOI: http://dx.doi.org/10.1111/j.1467-9531.2010.01225.x.
    Steglich, Ch., T.A.B. Snijders, and P. West (2006), Applying SIENA: An illustrative analysis of the co-evolution of adolescents' friendship networks, taste in music, and alcohol consumption. Methodology, 2, 48-56.
    Veenstra, R., and Ch. Steglich (2012). Actor-based model for network and behavior dynamics: A tool to examine selection and influence processes. Chapter 34 (pp. 598-618) in B. Laursen, T. D. Little, and N. A. Card (Eds.), Handbook of developmental research methods. New York: Guilford Press. 


Back to the Siena data sets page
