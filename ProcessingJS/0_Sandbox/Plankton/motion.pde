final int LINEAR = 1;
final int CIRCULAR = 2;

public class DoubleMotion
{
    private double changeMin;
    private double changeMax;
    private double speedMin;
    private double speed;
    private double speedMax;
    private double probability;
    private int doubleMotionType;

    private double baseValue;
    private double current;
    private double targetValue;
    private double x;

    private bool isActive;

    public double Current()
    {
        return current;
    }

    public DoubleMotion(double current)
    {
        this.isActive = false;
        this.parent = parent;
        this.current = current;
    }

    public DoubleMotion(double current, double changeMin, double changeMax, double speedMin, double speedMax, double probability, int doubleMotionType)
    {
        this.isActive = true;
        this.parent = parent;
        this.current = current;
        this.changeMin = changeMin;
        this.changeMax = changeMax;
        this.speedMin = speedMin;
        this.speedMax = speedMax;
        this.probability = probability;
        this.doubleMotionType = doubleMotionType;

        SetupNewTargetAndSpeed();
    }

    private void SetupNewTargetAndSpeed()
    {
        switch (doubleMotionType)
        {
            case LINEAR:
                this.baseValue = this.current;
                this.targetValue = random(changeMin, changeMax);
                break;
            case CIRCULAR:
                if (this.current < 0)
                {
                    this.current = TWO_PI + this.current;
                }
                else if (this.current > TWO_PI)
                {
                    this.current = this.current - TWO_PI;
                }

                this.baseValue = this.current;
                this.targetValue = this.current + random(changeMin, changeMax);
                break;
        }

        this.speed = random(speedMin, speedMax);
        this.x = 0;
    }

    private double Tween(double x, double baseValue, double targetValue)
    {
        double y;
        double diff = targetValue - baseValue;
        if (x <= 0.5)
        {
            double x1 = x * 2;
            double y1 = (x1 * x1) * 0.5;
            y = y1 * diff + baseValue;
        }
        else
        {
            double x1 = (x - 0.5) * 2;
            double x2 = 1 - x1;
            double y1 = (x2 * x2) * 0.5;
            double y2 = 1 - y1;
            y = y2 * diff + baseValue;
        }
        return y;
    }

    public double GetNext()
    {
        if (isActive)
        {
            if (x >= 1)
            {
                if (random(1) < probability)
                {
                    SetupNewTargetAndSpeed();
                }
            }
            else
            {
                current = Tween(x, baseValue, targetValue);
                x += this.speed;
            }
        }

        return current;
    }
}