import 'package:flutter/material.dart';
import 'package:train_schedule/models/StationModel.dart';

class InputField extends StatelessWidget {
  final TextEditingController _controller;
  final String _textField;
  final Function _setTextField;
  final Function _clearTextField;
  final String _hintField;
  final StationModel _stationModel;
  final FocusNode _focus;
  final FocusNode _nextFocus;

  InputField(
    this._hintField,
    this._textField,
    this._stationModel,
    this._setTextField,
    this._clearTextField,
    this._focus, {
    FocusNode nextFocus,
  })  : this._nextFocus = nextFocus,
        _controller = TextEditingController() {
    _controller.value = TextEditingValue(
      text: _textField,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _textField.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (text) => _setTextField(text),
      decoration: InputDecoration(
        labelText: _hintField,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15),
          borderSide: new BorderSide(),
        ),
        suffixIcon: IconButton(
          onPressed: () => _clearTextField(),
          icon: Icon(Icons.clear),
        ),
      ),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textInputAction:
          _nextFocus != null ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (term) {
        _focus.unfocus();
        if(_nextFocus != null) FocusScope.of(context).requestFocus(_nextFocus);
      },
      focusNode: _focus,
      validator: (value) {
        if (value.isEmpty)
          return 'Поле не повинно бути порожнім';
        else if (_stationModel == null)
          return 'Інформація вказана не вірно';
        else
          return null;
      },
    );
  }
}
