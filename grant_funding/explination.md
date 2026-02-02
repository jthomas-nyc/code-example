<b>Context:</b> This query was developed as part of an exploratory Looker Studio Dashboard built for
a project manager at Digital Science. The goal was twofold: first, identify growth trends across
different research categorizations and second, to assess data completeness of data by object
type. This analysis helped determine whether our standaridized categorization codes provided
enough specificity for our stakeholders or if we needed to pivot toward “Concepts” (machine
learning derived keywords) for granular insights.

<b>Tools used:</b>
Big Query (primary data warehouse), Looker Studio for visualization and formatting.

<b>Outcomes:</b>
* Identified that FoR data was the most complete and varied major categorization for most
object types. In general FoR2 provided the minimum expected specificity of data by end
users, For1 was too broad and only included in Sankey type analyses in most reports.
* There was Anomalous Growth from Covid-19 research across many categorizations,
since this was significant but broad it was easy to qualify outliers.
* While FoR2 was informative and performant, it in many cases was still overly broad and
unevenly distributed. This motivated us to explore “Document Sets” -&gt; exported results
based on free text filters and the use of “relevant concepts -&gt; machine learning scraped
keywords from indexed documents with a relevancy score set to greater than 0.5 to
weed out overly generic concepts. This allowed for more nuanced search capabilities in
our dashboards.
