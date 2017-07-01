$(document).ready(function () {
    $('#confirm-delete').on('click', '.btn-ok', function (e) {
        var $modalDiv = $(e.delegateTarget);
        var id = $(this).data('recordId');
        $modalDiv.addClass('loading');
        $.ajax({
            url: '/search/' + id,
            type: 'DELETE',
            success: function (result) {
                $modalDiv.modal('hide').removeClass('loading');
                $('#search-button').click();
            }
        });
    });
    $('#confirm-delete').on('show.bs.modal', function (e) {
        var data = $(e.relatedTarget).data();
        $('.btn-ok', this).data('recordId', data.recordid);
    });
});