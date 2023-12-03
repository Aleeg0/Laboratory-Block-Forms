Unit OutputArrayBUnit1_4;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids;

Type
    TOutputArrayB = Class(TForm)
        ElementsOfNewArray: TStringGrid;
        Procedure FormCreate(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    OutputArrayB: TOutputArrayB;

Implementation

{$R *.dfm}

Uses BackEndUnit1_4, MainFormUnit1_4;

Procedure TOutputArrayB.FormCreate(Sender: TObject);
Var
    Size, I: Integer;
    ArrayOfElements: TArrayOfInt;
Begin
    Size := Transformator.GetSizeOfArray();
    ArrayOfElements := Transformator.GetTransformatedArray();
    ElementsOfNewArray.ColCount := Size + 1;
    ElementsOfNewArray.RowCount := 2;
    ElementsOfNewArray.FixedCols := 1;
    ElementsOfNewArray.FixedRows := 1;
    ElementsOfNewArray.Cells[0, 0] := '№';
    ElementsOfNewArray.Cells[0, 1] := 'Элемент';
    For I := 1 To Size Do
    Begin
        ElementsOfNewArray.Cells[I, 0] := IntToStr(I);
        ElementsOfNewArray.Cells[I, 1] := IntToStr(ArrayOfElements[I - 1]);
    End;
End;

End.
