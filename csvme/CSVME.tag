<CSVME>

    <div class='cf'>

        <article class='w-100 center'>

            <h1 class='mb3 bg-near-black ma0 white pl3 pv3 fw6'>CSV<span class='silver f4'>.me</span></h1>

            <div class='pa3 db pt1 pb4 cf'>

                <nav class='w-50 fl relative shift-down'>
                    <BigButton onclick={ showImport } classes='mr3 bb-hide' >import</BigButton>
                    <BigButton onclick={ showExport } disabled={ !sourceData } classes='bb-hide'>export</BigButton>
                </nav>

                <div id="container" class='cf w-100 fl' if={ currentView }>

                    <div if={ currentView == 'import' }>
                        <div class='bg-near-black white w-100 cf ma0'>
                            <div class='w-50 fl pa3 tl'>
                                <label><input type="checkbox" name="hasHeaders"><span class='ml2 i f5'>Use first line for column headers</span></label>
                            </div>
                            <div class='w-50 fl pv2 ph3 tr relative shift-down'>
                                <span class='mr2 i f5 dib relative'>Inside a cell, swap out this character for commas:</span>
                                <input maxlength="1" class='relative input-reset f6 b--none pa2 w-10 dib' type="text" name="swapper">
                            </div>
                        </div>
                        <textarea class='w-100 fl ba bw2 b--black pa2' onkeyup={ updateImport } style="min-height: 500px" id="import"></textarea>
                        <div class='fl w-50 tl relative shift-up'>
                            <BigButton onclick={ clickClose }>
                                <svg class="center f2 db icon icon-cross" aria-labelledby="Close"><use xlink:href="#icon-cross"></use></svg>
                            </BigButton>
                        </div>
                        <div class='fl w-50 tr relative shift-up'>
                            <BigButton onclick={ importData } disabled={ canImport() }>
                                <svg class="center f2 db icon icon-check" aria-labelledby="Finish Import">
                                    <use xlink:href="#icon-check"></use>
                                </svg>
                            </BigButton>
                        </div>
                    </div>

                    <div if={ currentView == 'export' }>
                        <textarea class='fl w-100 ba bw2 b--black pa2' style="min-height: 500px" id="export"></textarea>
                        <div class='fl w-50 tl relative shift-up'>
                            <BigButton onclick={ clickClose }>
                                <svg class="center f2 db icon icon-arrow-left" aria-labelledby="Close Export"><use xlink:href="#icon-arrow-left"></use></svg>
                            </BigButton>
                        </div>
                    </div>

                    <div class='table cf' if={ currentView == "table" }>

                        <p class='mv4 i f5' if={ !rows.length }>Import your CSV to get started.</p>

                        <table class='ba bw2 b--black w-100' if={ rows.length }>

                            <thead if={ columnHeaders.length }>
                                <tr class='bg-near-black white ttu'>
                                    <th class='pv2' each={ header, i in columnHeaders }>
                                        { header }
                                    </th>
                                </tr>
                            </thead>

                            <tbody id="grid">
                                <tr each={ row, y in rows } class='mb2 striped--near-white bb csv-row'>
                                    <td each={ val, x in row } class=''>
                                        <input
                                            type="text"
                                            class='input-reset f6 b--none pa2 db w-100'
                                            onkeydown={ handleKey }
                                            onchange={ handleUpdate }
                                            value="{ swapComma(val) }"
                                            placeholder="{ columnHeaders.length ? columnHeaders[x] : '' }"
                                            data-gridX={ x }
                                            data-gridY={ y }
                                            >
                                    </td>
                                </tr>
                            </tbody>

                        </table>

                        <div class='w-80 fl'>
                            <p class='mv3 i f5' if={ rows.length }>Press ENTER edit a cell. Press ENTER again when finished to return to the grid.</p>
                            <p class='mv3 i f5' if={ rows.length }>SHIFT+A to add a new row; SHIFT+E to export.</p>
                        </div>

                        <div class='w-20 fl tr relative shift-up' if={ currentView == 'table' }>
                            <BigButton if={ rows.length } onclick={ addRow } class='bt-hide'>add row</BigButton>
                        </div>

                        <FocusMode if={ focusActive } coords={ focusCoords } val={ focusTarget }></FocusMode>

                    </div>

                </div>

            </div>

        </article>



    </div>

    <style scoped>

        table {
            border-collapse: separate;
        }
        .shift-down {
            bottom: -0.25rem;
        }
        .shift-up {
            top: -0.25rem;
        }

    </style>

    <script>

        var tag = this;
        tag.sourceData = null;
        tag.parsedData = [];
        tag.columnHeaders = [];
        tag.rows = [];
        tag.$rows = [];
        tag.currentView = 'table';
        tag.columnCount = 0;
        tag.currentSwapper = '';
        tag.focusActive = false;
        tag.focusCoords = [];
        tag.focusTarget = '';
        tag.focusInput = null;


        tag.showImport = function(e) {
            tag.currentView = 'import';
            tag.update();
        }

        tag.updateImport = function(e) {
            if(tag.import.value.length > 1) {
                tag.update();
            }
            return true;
        }

        tag.canImport = function(){
            if(tag.import.value.length) {
                return false;
            }
            return true;
        }

        tag.importData = function(){
            var toImport = tag.import.value;
            if(toImport.length) {
                tag.sourceData = toImport;
                tag.rows = toImport.split("\n");
                tag.rows = _.map(tag.rows, function(row){
                    return row.split(",");
                });
                if(tag.hasHeaders.checked) {
                    tag.columnHeaders = tag.rows.shift();
                    tag.columnCount = tag.columnHeaders.length;
                    if(!tag.rows.length) {
                        tag.addRow();
                    }
                    _.each(tag.rows, function(row){
                        while(row.length < tag.columnCount) {
                            row.push("");
                        }
                    });
                }
                else {
                    tag.columnCount = tag.rows[0].length;
                }
                tag.currentView = 'table';
            }
            if(tag.swapper.value.length === 1) {
                var newSwapper = tag.swapper.value;
                if(newSwapper === ',' || newSwapper === '') {
                    tag.update();
                    return;
                }
                tag.currentSwapper = newSwapper;
                tag.swapReg = new RegExp("\\" + tag.currentSwapper, 'gi');
                tag.exportReg = new RegExp(",", 'gi');
            }
            tag.update();
            tag.registerRows();
        }

        tag.showExport = function(e) {
            tag.currentView = 'export';
            var dataForExport = tag.exportData();
            tag.export.value = dataForExport;
            tag.update();
        }

        tag.exportData = function(){
            var final = _.join(tag.columnHeaders, ',') + "\n";
            _.forEach(tag.rows, function(row){
                var swapped = _.map(row, function(val){
                    return val.replace(tag.exportReg, tag.currentSwapper);
                });
                var invalidRow = _.every(swapped, function(c){
                    return c === "" || c === " ";
                });
                if(!invalidRow) {
                    final += _.join(swapped, ',') + "\n";
                }
            });
            final = _.trimEnd(final, '\n');
            return final;
        }

        tag.addRow = function(){
            var newRow = [];
            _.times(tag.columnCount, function(){
                newRow.push("");
            });
            tag.rows.push(newRow);
            tag.update();
            tag.registerRows();
        }

        tag.handleUpdate = function(e){
            var origin = e.currentTarget.dataset;
            tag.updateRow(origin.gridx, origin.gridy, e.currentTarget.value);
        }

        tag.updateRow = function(x, y, newValue) {
            tag.rows[y][x] = newValue;
            tag.update();
        }

        tag.clickClose = function(){
            tag.currentView = 'table';
            tag.update();
        }

        tag.registerRows = function(){
            tag.$rows = tag.grid.querySelectorAll('.csv-row');
        }

        tag.swapComma = function(txt) {
            if(tag.currentSwapper != '') {
                return txt.replace(tag.swapReg, ',');
            }
            return txt;
        }

        tag.validCoords = function(x,y) {
            var maxX = tag.rows[0].length;
            var maxY = tag.rows.length;
            return x > -1 && x < maxX && y > -1 && y < maxY;
        }

        tag.moveCell = function(origin, x,y) {
            var destX = parseInt(origin.dataset.gridx) + x;
            var destY = parseInt(origin.dataset.gridy) + y;
            if(tag.validCoords(destX, destY)) {
                var $row = tag.$rows[destY];
                var cell = $row.getElementsByTagName("input")[destX];
                cell.focus();
            }
        }

        tag.handleKey = function(e){
            var code = e.keyCode;
            if(code === 37) {
                tag.moveCell(e.currentTarget, -1, 0);
            }
            else if(code === 38) {
                tag.moveCell(e.currentTarget, 0, -1);
            }
            else if(code === 39) {
                tag.moveCell(e.currentTarget, 1, 0);
            }
            else if(code === 40) {
                tag.moveCell(e.currentTarget, 0, 1);
            }
            else if(code === 9) {
                tag.moveCell(e.currentTarget, 1, 0);
            }
            else if(code === 8) {
                tag.emptyCell(e.currentTarget);
            }
            else if(!e.shiftKey) {
                var origin = e.currentTarget.dataset;
                tag.focusActive = true;
                tag.focusCoords = [origin.gridx, origin.gridy];
                tag.focusTarget = tag.swapComma(this.val);
                tag.focusInput = e.currentTarget;
                tag.update();
                tag.tags.focusmode.takeFocus();
            }
            return false;
        }

        tag.emptyCell = function(target) {
            var origin = target.dataset;
            tag.updateRow(origin.gridx, origin.gridy, '');
        }

        tag.handleShift = function(e) {
            var code = e.keyCode;
            if(tag.rows.length && tag.currentView === 'table' && !tag.focusActive) {
                if(e.shiftKey) {
                    if(code === 65) {
                        tag.addRow();
                    }
                    else if(code === 69) {
                        tag.showExport();
                    }
                }
            }
            return false;
        }

        tag.on('mount', function(){
            document.addEventListener('keyup', tag.handleShift);
        });

    </script>

</CSVME>

<BigButton>
    <button class='bg-transparent tc pa2 ph3 ba bw2 b--black hover-invert cursor-pointer {opts.classes || ""}' disabled={ opts.__disabled }>
        <yield />
    </button>

    <style scoped>
        button:disabled {
            opacity: 0.5;
        }
        button:disabled:hover {
            background-color: transparent;
            cursor: default;
            color: graytext;
        }
        button:disabled:hover svg {
            fill: graytext;
        }
    </style>
</BigButton>

<FocusMode>

    <div id="focus" class='fixed w-100 pa3'>

        <textarea class='w-100 pa2 ba bw2 b--black { opts.val && opts.val.length > 50 ? "focus-tall" : "" }' id="focusInput" onkeyup={ handleKeyUp }>{ opts.val || '' }</textarea>

    </div>

    <style scoped>
        #focus {
            bottom: 0;
            left: 0;
        }
        #focus .focus-tall {
            height: 150px;
        }
    </style>

    <script>

        var tag = this;
        var parent = this.parent;
        tag.ready = false;

        tag.handleKeyUp = function(e) {
            if(e.keyCode != 13) {
                tag.handleChange(e);
            }
            else {
                tag.finishFocus();
                tag.ready = true;
                return false;
            }
            tag.ready = true;
            return true;
        }

        tag.finishFocus = function(){
            if(!tag.ready) {
                return;
            }
            tag.focusInput.value = '';
            parent.focusActive = false;
            parent.focusCoords = [];
            parent.focusTarget = '';
            parent.focusInput.focus();
            parent.focusInput = null;
            parent.update();
        }

        tag.takeFocus = function(){
            tag.ready = false;
            tag.focusInput.focus();
        }

        tag.handleChange = function(e) {
            var coords = parent.focusCoords;
            parent.updateRow(coords[0], coords[1], e.currentTarget.value);
        }

    </script>

</FocusMode>