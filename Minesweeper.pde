import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < buttons.length; r++)
    {
        for(int c = 0; c < buttons[r].length; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    setBombs();
}
public void setBombs()
{
    while(bombs.size() < 50)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);        
        if(!bombs.contains(buttons[row][col]))
            bombs.add(buttons[row][col]);
    }
}
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
    for(int c = 0; c < NUM_COLS; c++)
    {
      if(!buttons[r][c].isClicked() == true && !bombs.contains(buttons[r][c]))
      {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked() && bombs.contains(buttons[r][c]))
            {
                buttons[r][c].marked = false;
                buttons[r][c].clicked = true;
                buttons[0][5].setLabel("G");
                buttons[0][6].setLabel("A");
                buttons[0][7].setLabel("M");
                buttons[0][8].setLabel("E");
                buttons[0][9].setLabel("");
                buttons[0][10].setLabel("");
                buttons[0][11].setLabel("O");
                buttons[0][12].setLabel("V");
                buttons[0][13].setLabel("E");
                buttons[0][14].setLabel("R");
            }
        }
    }
}
public void displayWinningMessage()
{
    buttons[0][6].setLabel("Y");
    buttons[0][7].setLabel("O");
    buttons[0][8].setLabel("U");
    buttons[0][9].setLabel("");
    buttons[0][10].setLabel("");
    buttons[0][11].setLabel("W");
    buttons[0][12].setLabel("I");
    buttons[0][13].setLabel("N");
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT)
        {
            marked = !marked;
            if(marked == false)
            {
                clicked = false;
            }
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            setLabel("" + countBombs(r,c));
        }
        else
        {
            if(isValid(r,c-1) && buttons[r][c-1].clicked == false)
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].clicked == false)
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].clicked == false)
                buttons[r-1][c].mousePressed();  
            if(isValid(r+1,c) && buttons[r+1][c].clicked == false)
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked == false)
                buttons[r+1][c+1].mousePressed();
            if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked == false)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked == false)
                buttons[r-1][c-1].mousePressed();    
            if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked == false)
                buttons[r-1][c+1].mousePressed();        
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill(150);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(255);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;
        else
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
            numBombs++;  
        if(isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
            numBombs++;   
        if(isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;   
        if(isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;   
        if(isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;   
        if(isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;   
        return numBombs;
    }
}