class Matrix2D
{
  float m00; float m01; float m02;
  float m10; float m11; float m12;
  float m20; float m21; float m22;

  public Matrix2D()
  {
    reset();
  }
  
  public Matrix2D
  (
    float m00, float m01, float m02,
    float m10, float m11, float m12,
    float m20, float m21, float m22
  )
  {
    set
    (
      m00, m01, m02,
      m10, m11, m12,
      m20, m21, m22
    );
  }
  
  public void reset()
  {
    set
    (
      1, 0, 0,
      0, 1, 0,
      0, 0, 1
    );
  }
  
  public void set(Matrix2D b)
  {
    set
    (
      b.m00, b.m01, b.m02,
      b.m10, b.m11, b.m12,
      b.m20, b.m21, b.m22
    );
  }
  
  public void set
  (
    float m00, float m01, float m02,
    float m10, float m11, float m12,
    float m20, float m21, float m22
  )
  {
    this.m00 = m00; this.m01 = m01; this.m02 = m02;
    this.m10 = m10; this.m11 = m11; this.m12 = m12;
    this.m20 = m20; this.m21 = m21; this.m22 = m22;
  }
  
  public void addDirectXY(float x, float y)
  {
     m02 = m02+x;
     m12 = m12+y;
  }
  
  int[] applyToPoint(int x, int y)
  {
    int[] xy = new int[2];
    float[] xyA = new float[3];  
    float[] xyB = new float[3];
    xyA[0] = x; 
    xyA[1] = y; 
    xyA[2] = 1;
    
    xyB[0] = m00*xyA[0] + m01*xyA[1] + m02*xyA[2];
    xyB[1] = m10*xyA[0] + m11*xyA[1] + m12*xyA[2]; 
    xyB[2] = m20*xyA[0] + m21*xyA[1] + m22*xyA[2];
    
    xy[0] = (int) xyB[0]; 
    xy[1] = (int) xyB[1];
    
    return xy;
  }
  
  Matrix2D multiply(Matrix2D b)
  {
    return new Matrix2D
    (
      m00*b.m00 + m01*b.m10 + m02*b.m20,   m00*b.m01 + m01*b.m11 + m02*b.m21,   m00*b.m02 + m01*b.m12 + m02*b.m22,
      m10*b.m00 + m11*b.m10 + m12*b.m20,   m10*b.m01 + m11*b.m11 + m12*b.m21,   m10*b.m02 + m11*b.m12 + m12*b.m22,
      m20*b.m00 + m21*b.m10 + m22*b.m20,   m20*b.m01 + m21*b.m11 + m22*b.m21,   m20*b.m02 + m21*b.m12 + m22*b.m22
    );
  }
  
  void translate(float x, float y)
  {
    set(multiply(new Matrix2D_Translation(x, y)));
  }
  
  void rotate(float a)
  {
    set(multiply(new Matrix2D_Rotation(a)));
  }
  
  void scale(float x, float y)
  {
    set(multiply(new Matrix2D_Scale(x, y)));
  }
}


class Matrix2D_Translation extends Matrix2D
{
  public Matrix2D_Translation(float x, float y)
  {
    set
    (
      1, 0, x,
      0, 1, y,
      0, 0, 1
    );
  }
}

class Matrix2D_Rotation extends Matrix2D
{
  public Matrix2D_Rotation(float a)
  {
    float c = cos(a);
    float s = sin(a);
    float S = -sin(a);
    set
    (
      c, S, 0,
      s, c, 0,
      0, 0, 1
    );
  }
}

class Matrix2D_Scale extends Matrix2D
{
  public Matrix2D_Scale(float x, float y)
  {
    set
    (
      x, 0, 0,
      0, y, 0,
      0, 0, 1
    );
  }
}
