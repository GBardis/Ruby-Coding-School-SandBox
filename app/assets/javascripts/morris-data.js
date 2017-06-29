$(function() {
    if ($('#histogram-chart').length && histogram_data) {
        Morris.Area({
            element: 'histogram-chart',
            data: histogram_data,
            xkey: 'date',
            ykeys: ['tri'],
            labels: ['Tri'],
            pointSize: 2,
            hideHover: 'auto',
            resize: true
        });
    }
});
