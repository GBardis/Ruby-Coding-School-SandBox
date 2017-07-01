$(document).ready(function () {
    var triIndex = $('#dataTables-example th.threat_tri').index();
    if (triIndex < 0) triIndex = 1;
    var table = $('#dataTables-example').DataTable({
        "processing": true,
        "serverSide": true,
        "smart": false,
        "searchDelay": 850,
        "order": [[triIndex, 'desc']],
        //"scrollX": true,
        //"scrollY":        "600px",
        //"scrollCollapse": true,
        //"fixedHeader": true,
        //"responsive": true,
        "language": {
            "search": ""
        },
        "columnDefs": [
            {
                "targets": ["edit-button"],
                "className": "edit-button",
                "data": null,
                "render": function (data, type, full, meta) {
                    return "<a href='search/" + data['id'] +
                        "/edit' class='btn btn-success' data-skip='true'>Edit</a>";
                }
            },
            {
                "targets": ["delete-button"],
                "className": "delete-button",
                "data": null,
                "render": function (data, type, full, meta) {
                    return "<button class='btn btn-warning' data-recordId='" + data['id'] +
                        "' data-toggle='modal' data-target='#confirm-delete' data-skip='true'>Delete</button>";
                }
            }
        ],
        "ajax": {
            type: 'POST',
            url: '/api/search_api/',
            data: function (data) {
                var new_data = {
                    draw: data.draw,
                    start: data.start,
                    length: data.length,
                    term: data.search['value'],
                    regex: data.search['regex'],
                    order_column_name: data.columns[data.order[0]['column']]['name'],
                    order_dir: data.order[0]['dir']
                }
                return new_data;
            },
            dataFilter: function (data) {
                return data;
            }
        },
        "initComplete": function () {
            var input = $('.dataTables_filter input').unbind(),
                self = this.api(),
                $searchButton = $('<button id="search-button" type="button" class="btn btn-outline btn-primary btn-circle"><i class="fa fa-search"></i></button>')
                    .click(function () {
                        self.search(input.val()).draw();
                    }),
                $clearButton = $('<button id="clear-button" type="button" class="btn btn-outline btn-warning btn-circle"><i class="fa fa-times"></i></button>')
                    .click(function () {
                        input.val('');
                        $searchButton.click();
                    });
            input.bind('keyup', function (e) {
                if (e.keyCode == 13) {
                    self.search(input.val()).draw();
                }
            });
            $('.dataTables_filter').append($searchButton, $clearButton);
        }
    });

    $('#dataTables-example tbody').on('click', 'tr', function (event) {
        if (event.target.attributes['data-skip'])
            return;
        var data = table.row(this).data();
        window.location.href = '/search/' + data['id'];
    });
});