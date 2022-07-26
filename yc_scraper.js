import fetch from 'node-fetch';

(async () => {
    let batches = ['S21', 'W21', 'S22', 'W22', 'S23'];
    for(let i = 0; i < batches.length; i ++) {
        let batch = batches[i];
        let page = await fetch(`https://api.ycombinator.com/v0.1/companies?batch=${batch}`);
        let pageJson = await page.json();
        console.log(`Batch ${batch} Page ${pageJson.page+1} of ${pageJson.totalPages}`);
        for(let j = 0; j < pageJson.companies.length; j++) {
            const company = pageJson.companies[j];
            try{
                const html = await fetch(company.website);
                const html_text = await html.text();
                const githubs = html_text.match(/github.com\/[-A-Za-z0-9_./]+/g);
                console.log(`${company.name}, ${company.website}, ${company.url}, [${githubs ? githubs.toString().replace(",","|") : ''}]`);    
            } catch(e) {
                console.log(`${company.name}, ${company.website} #SITEDOWN, ${company.url}, []`);
            }
        }
        while(pageJson.nextPage !== undefined){
            page = await fetch(pageJson.nextPage);
            pageJson = await page.json();
            console.log(`Batch ${batch} Page ${pageJson.page+1} of ${pageJson.totalPages}`);
            for(let j = 0; j < pageJson.companies.length; j++) {
                const company = pageJson.companies[j];
                try{
                    const html = await fetch(company.website);
                    const html_text = await html.text();
                    const githubs = html_text.match(/github.com\/[-A-Za-z0-9_./]+/g);
                    console.log(`${company.name}, ${company.website}, ${company.url}, [${githubs ? githubs.toString().replace(",","|") : ''}]`);    
                } catch(e) {
                    console.log(`${company.name}, ${company.website} #SITEDOWN, ${company.url}, []`);
                }
            }
        }
    }
})();
